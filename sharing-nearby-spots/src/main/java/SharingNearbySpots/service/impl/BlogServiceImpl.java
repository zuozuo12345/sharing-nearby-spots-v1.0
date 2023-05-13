package SharingNearbySpots.service.impl;

import SharingNearbySpots.dto.Result;
import SharingNearbySpots.dto.ScrollResult;
import SharingNearbySpots.dto.UserDTO;
import SharingNearbySpots.entity.Blog;
import SharingNearbySpots.entity.Follow;
import SharingNearbySpots.entity.Shop;
import SharingNearbySpots.entity.User;
import SharingNearbySpots.mapper.BlogMapper;
import SharingNearbySpots.service.IBlogService;
import SharingNearbySpots.service.IFollowService;
import SharingNearbySpots.service.IShopService;
import SharingNearbySpots.service.IUserService;
import SharingNearbySpots.utils.SystemConstants;
import SharingNearbySpots.utils.UserHolder;
import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import static SharingNearbySpots.utils.RedisConstants.BLOG_LIKED_KEY;
import static SharingNearbySpots.utils.RedisConstants.FEED_KEY;


@Service
public class BlogServiceImpl extends ServiceImpl<BlogMapper, Blog> implements IBlogService {

    @Resource
    private IUserService userService;


    @Resource
    private IShopService shopService;

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    @Resource
    private IFollowService followService;

    @Override
    public Result savaBlog(Blog blog) {
        // 获取登录用户
        UserDTO user = UserHolder.getUser();
        blog.setUserId(user.getId());
        blog.setNickName(user.getNickName());
        blog.setIcon(user.getIcon());
        // 保存探店博文
        save(blog);
        //查询所有粉丝
        List<Follow> follows = followService.query().eq("follow_user_id", user.getId()).list();
        //推送笔记id给所有粉丝
        for(Follow follow : follows)
        {
            //获取粉丝id
            Long userId = follow.getUserId();
            //推送
            String key =  FEED_KEY + userId;
            stringRedisTemplate.opsForZSet().add(key,blog.getId().toString(), System.currentTimeMillis());
        }
        // 返回id
        return Result.ok(blog.getId());
    }

    @Override
    public Result likeBlog(Long id) {
        //获取登录用户
        Long userId = UserHolder.getUser().getId();
        //判断当前用户是否点赞
        String key = BLOG_LIKED_KEY + id;
        Double score = stringRedisTemplate.opsForZSet().score(key, userId.toString());
        if(score == null)
        {
            //未点赞
            //数据库点赞数+1
            boolean isSuccess = update().setSql("liked = liked + 1").eq("id", id).update();
            //保存用户到redis的set集合
            if(isSuccess)
            {
                stringRedisTemplate.opsForZSet().add(key,userId.toString(),System.currentTimeMillis());
            }
        }
        else
        {
            //如果已经点赞，取消点赞
            //数据库点赞数 -1
            boolean isSuccess = update().setSql("liked = liked - 1").eq("id", id).update();
            //把用户从redis的set集合移除
            if(isSuccess)
            {
                stringRedisTemplate.opsForZSet().remove(key,userId.toString());
            }
        }
        return Result.ok();
    }

    @Override
    public Result queryHotBlog(Integer current) {
        // 根据用户查询
        Page<Blog> page = query()
                .orderByDesc("liked")
                .page(new Page<>(current, SystemConstants.MAX_PAGE_SIZE));
        // 获取当前页数据
        List<Blog> records = page.getRecords();
        // 查询用户
        records.forEach(blog ->
        {
            this.queryBlogUser(blog);
            this.isBlogLiked(blog);
        });
        return Result.ok(records);
    }

    @Override
    public Result queryBlogById(Long id) {
        //查询blog
        Blog blog = getById(id);
        if(blog == null)
        {
            return Result.fail("No such blog exist.");
        }
        //查询blog有关的用户
        queryBlogUser(blog);
        //查询是否点赞了
        isBlogLiked(blog);
        return Result.ok(blog);
    }


    private void isBlogLiked(Blog blog) {
        //获取登录用户
//        Long userId = UserHolder.getUser().getId();
        UserDTO user = UserHolder.getUser();
        if(user == null)
        {
            return;
        }
        Long userId = user.getId();
        //判断当前用户是否点赞
        String key = BLOG_LIKED_KEY + blog.getId();
        Double score = stringRedisTemplate.opsForZSet().score(key, userId.toString());
        blog.setIsLike(score != null);

    }

    private void queryBlogUser(Blog blog) {
        Long userId = blog.getUserId();
        User user = userService.getById(userId);
//        blog.setNickName(user.getNickName());
//        blog.setIcon(user.getIcon());
    }

    @Override
    public Result queryBlogLikes(Long id) {
        //查询top5用户，zrange，查到是用户id
        String key = BLOG_LIKED_KEY + id;
        //解析出其中的用户id
        Set<String> top5 = stringRedisTemplate.opsForZSet().range(key, 0, 4);
        if(top5 == null || top5.isEmpty())
        {
            return Result.ok(Collections.emptyList());
        }
        //根据用户id查询用户
        List<Long> ids = top5.stream().map(Long::valueOf).collect(Collectors.toList());
        String idStr = StrUtil.join(",", ids);
        //返回
        List<UserDTO> userDTOS = userService.query()
                .in("id",ids).last("ORDER BY FIELD(id, " + idStr +")").list()
                .stream()
                .map(user -> BeanUtil.copyProperties(user, UserDTO.class))
                .collect(Collectors.toList());

        return Result.ok(userDTOS);
    }

    @Override
    public Result queryBlogOfFollow(Long max, Integer offset) {
        // 获取当前用户
        Long userId = UserHolder.getUser().getId();
        //查询收件箱     ZREVRANGEBYSCORE key Max Min LIMIT offset count
        String key = FEED_KEY + userId;
        Set<ZSetOperations.TypedTuple<String>> typedTuples = stringRedisTemplate.opsForZSet()
                .reverseRangeByScoreWithScores(key, 0, max, offset, 2);
        //非空判断
        if(typedTuples == null || typedTuples.isEmpty())
        {
            return Result.ok("Empty.");
        }
        //解析数据 blogid， 最小时间戳，offset（和查询的最小值一样的个数），前端要blog集合
        List<Long> ids = new ArrayList<>(typedTuples.size());
        long minTime = 0;
        int os = 1;
        for(ZSetOperations.TypedTuple<String> tuple : typedTuples)
        {
            ids.add(Long.valueOf(tuple.getValue()));
            long time = tuple.getScore().longValue();
            if(time == minTime)
            {
                os++;
            }else
            {
                minTime = time;
                os = 1;
            }

            minTime = tuple.getScore().longValue();

        }
        //根据id查询blog
        String idStr = StrUtil.join(",", ids);

        List<Blog> blogs = query()
                .in("id",ids).last("ORDER BY FIELD(id, " + idStr +")").list();
        for(Blog blog:blogs)
        {
            queryBlogUser(blog);
            //查询是否点赞了
            isBlogLiked(blog);
        }
        //封装返回
        ScrollResult r = new ScrollResult();
        r.setList(blogs);
        r.setOffset(os);
        r.setMinTime(minTime);
        return Result.ok(r);
    }

    @Override
    public Result queryBolgByShopId(Long shopId) {
//        Shop shop = shopService.getById(shop_id);
//        List<Blog> blogs = query()
//                .eq("shop_id", shop_id).list();
//        // 返回数据
//        return Result.ok(blogs);
//        Page<Shop> page = query()
//                .eq("type_id", typeId).orderByDesc("score")
//                .page(new Page<>(current, SystemConstants.DEFAULT_PAGE_SIZE));
//        // 返回数据
//        return Result.ok(page.getRecords());

//        if(blog == null)
//        {
//            return Result.fail("No such blog exist.");
//        }
//        //查询blog有关的用户
//        queryBlogUser(blog);
//        //查询是否点赞了
//        isBlogLiked(blog);
//        return Result.ok(blog);
        List<Blog> blogs = getBaseMapper().queryBolgByShopId(shopId);
        return Result.ok(blogs);
    }

    @Override
    public Result deleteBlog(Blog blog) {

        getBaseMapper().deleteById(blog.getId());
        return Result.ok("Delete successfully!");
    }

}

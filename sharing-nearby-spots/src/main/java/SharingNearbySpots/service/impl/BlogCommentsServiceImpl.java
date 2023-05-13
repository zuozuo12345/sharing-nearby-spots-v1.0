package SharingNearbySpots.service.impl;

import SharingNearbySpots.dto.Result;
import SharingNearbySpots.dto.UserDTO;
import SharingNearbySpots.entity.*;
import SharingNearbySpots.mapper.BlogCommentsMapper;
import SharingNearbySpots.service.*;
import SharingNearbySpots.utils.SystemConstants;
import SharingNearbySpots.utils.UserHolder;
import com.baomidou.mybatisplus.extension.conditions.query.QueryChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

import static SharingNearbySpots.utils.RedisConstants.BLOG_LIKED_KEY;
import static SharingNearbySpots.utils.RedisConstants.FEED_KEY;


@Service
public class BlogCommentsServiceImpl extends ServiceImpl<BlogCommentsMapper, BlogComments> implements IBlogCommentsService {

    @Resource
    private IUserService userService;

    @Resource
    private IBlogService blogService;

    @Resource
    private IShopService shopService;

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    @Resource
    private IFollowService followService;

    @Override
    public Result savaBlogComments(Long blogId, BlogComments blogComments) {
        UserDTO user = UserHolder.getUser();
        blogComments.setBlogId(blogId);
        blogComments.setUserId(user.getId());
        blogComments.setNickName(user.getNickName());
        blogComments.setIcon(user.getIcon());
        blogComments.setAnswerId((long)0);
        blogComments.setParentId((long)0);
        blogComments.setStatus(false);
        List<Blog> blogs = blogService.query().eq("id", blogId).list();
        for (Blog blog:blogs) {
            blogComments.setTitle(blog.getTitle());
            blogComments.setImages(blog.getImages());
        }

        // 保存探店博文评论
        save(blogComments);
//        List<Blog> blogs = blogService.query().eq("blog_id", blogComments.getBlogId()).list();
//        //推送笔记id给所有粉丝
//        for(Blog blog : blogs)
//        {
//            //获取粉丝id
//            Long userId = blog.getUserId();
//            //推送
//            String key =  FEED_KEY + userId;
//            stringRedisTemplate.opsForZSet().add(key,blog.getId().toString(), System.currentTimeMillis());
//        }
//         返回id
        return Result.ok(blogComments.getId());
    }

    @Override
    public Result likeBlogComments(Long id) {
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
    public Result queryBolgCommentsByBlogId(Long blogId, Integer current) {
        Page<BlogComments> page = query()
                .eq("blog_id", blogId).orderByDesc("id")
                .page(new Page<>(current, SystemConstants.MAX_PAGE_SIZE));
        // 返回数据
        return Result.ok(page.getRecords());
    }

    @Override
    public Result queryBolgCommentsById(Long id) {
        //查询blog
        BlogComments blogComments = getById(id);
        if(blogComments == null)
        {
            return Result.fail("No such blog exist.");
        }
        //查询blog有关的用户
        queryBlogCommentsUser(blogComments);
        //查询是否点赞了
        isBlogCommentsLiked(blogComments);
        return Result.ok(blogComments);
    }

    private void queryBlogCommentsUser(BlogComments blogComments) {
        Long userId = blogComments.getUserId();
        User user = userService.getById(userId);
//        blog.setNickName(user.getNickName());
//        blog.setIcon(user.getIcon());
    }

    private void isBlogCommentsLiked(BlogComments blogComments) {
        //获取登录用户
//        Long userId = UserHolder.getUser().getId();
        UserDTO user = UserHolder.getUser();
        if(user == null)
        {
            return;
        }
        Long userId = user.getId();
        //判断当前用户是否点赞
        String key = BLOG_LIKED_KEY + blogComments.getId();
        Double score = stringRedisTemplate.opsForZSet().score(key, userId.toString());
        blogComments.setIsLike(score != null);

    }


}

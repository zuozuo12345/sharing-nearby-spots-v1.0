package SharingNearbySpots.controller;


import SharingNearbySpots.dto.Result;
import SharingNearbySpots.dto.UserDTO;
import SharingNearbySpots.entity.Blog;
import SharingNearbySpots.entity.BlogComments;
import SharingNearbySpots.service.IBlogCommentsService;
import SharingNearbySpots.service.IBlogService;
import SharingNearbySpots.utils.SystemConstants;
import SharingNearbySpots.utils.UserHolder;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *

 */
@RestController
@RequestMapping("/blog-comments")
public class BlogCommentsController {
//    @Resource
//    private IBlogService blogService;

    @Resource
    private IBlogCommentsService blogCommentsService;

    @PostMapping("/{blogId}")
    public Result saveBlogComments(@PathVariable("blogId") Long blogId, @RequestBody BlogComments blogComments) {

        return blogCommentsService.savaBlogComments(blogId, blogComments);
    }


    @PutMapping("/like/{id}")
    public Result likeBlogComments(@PathVariable("id") Long id) {
        // 修改点赞数量
//        blogService.update()
//                .setSql("liked = liked + 1").eq("id", id).update();
        return blogCommentsService.likeBlogComments(id);
    }

    @GetMapping("/of/me")
    public Result queryMyBlogComments(@RequestParam(value = "current", defaultValue = "1") Integer current) {
        // 获取登录用户
        UserDTO user = UserHolder.getUser();
        // 根据用户查询
        Page<BlogComments> page = blogCommentsService.query()
                .eq("user_id", user.getId()).page(new Page<>(current, SystemConstants.MAX_PAGE_SIZE));
        // 获取当前页数据
        List<BlogComments> records = page.getRecords();
        return Result.ok(records);
    }
    @GetMapping("/{id}")
    public Result queryBolgComentsById(@PathVariable("id") Long id)
    {
        return blogCommentsService.queryBolgCommentsById(id);
    }


    @GetMapping("/blog/{blogId}")
    public Result queryBolgComentsByBlogId(@PathVariable("blogId") Long blogId,
                                           @RequestParam(value = "current", defaultValue = "1") Integer current)
    {
        return blogCommentsService.queryBolgCommentsByBlogId(blogId, current);
    }


}

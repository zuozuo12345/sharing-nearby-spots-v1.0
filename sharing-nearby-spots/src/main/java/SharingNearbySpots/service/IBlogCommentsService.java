package SharingNearbySpots.service;

import SharingNearbySpots.dto.Result;
import SharingNearbySpots.entity.BlogComments;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * <p>
 *  服务类
 * </p>
 *

 */
public interface IBlogCommentsService extends IService<BlogComments> {

    Result savaBlogComments(Long blogId, BlogComments blogComments);

    Result likeBlogComments(Long id);

    Result queryBolgCommentsByBlogId( Long blogId, Integer current);

    Result queryBolgCommentsById(Long id);

}

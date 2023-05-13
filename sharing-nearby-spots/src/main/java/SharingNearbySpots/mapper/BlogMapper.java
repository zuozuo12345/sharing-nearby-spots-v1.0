package SharingNearbySpots.mapper;

import SharingNearbySpots.entity.Blog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface BlogMapper extends BaseMapper<Blog> {

    List<Blog> queryBolgByShopId(@Param("shopId") Long shopId);

}

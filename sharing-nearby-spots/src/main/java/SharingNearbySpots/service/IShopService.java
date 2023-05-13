package SharingNearbySpots.service;

import SharingNearbySpots.dto.Result;
import SharingNearbySpots.entity.Shop;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *

 */
public interface IShopService extends IService<Shop> {


    Result queryById(Long id);

    Result update(Shop shop);

    Result queryShopByType(Integer typeId, Integer current, Double x, Double y);

    Result queryShopByType2(Integer typeId, Integer current, Double x, Double y);

}

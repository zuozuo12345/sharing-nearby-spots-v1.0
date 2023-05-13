package SharingNearbySpots.service;

import SharingNearbySpots.dto.Result;
import SharingNearbySpots.entity.ShopType;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *

 */
public interface IShopTypeService extends IService<ShopType> {

    Result getlist();
}

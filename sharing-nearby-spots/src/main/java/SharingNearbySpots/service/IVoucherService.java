package SharingNearbySpots.service;

import SharingNearbySpots.dto.Result;
import SharingNearbySpots.entity.Voucher;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>

 */
public interface IVoucherService extends IService<Voucher> {

    Result queryVoucherOfShop(Long shopId);

    void addSeckillVoucher(Voucher voucher);
}

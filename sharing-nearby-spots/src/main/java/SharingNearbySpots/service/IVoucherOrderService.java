package SharingNearbySpots.service;

import SharingNearbySpots.dto.Result;
import SharingNearbySpots.entity.Voucher;
import SharingNearbySpots.entity.VoucherOrder;
import com.baomidou.mybatisplus.extension.service.IService;

public interface IVoucherOrderService extends IService<VoucherOrder> {
    Result seckillVoucher(Long voucherId);

    Result createVoucherOrder(Long voucherId);

}

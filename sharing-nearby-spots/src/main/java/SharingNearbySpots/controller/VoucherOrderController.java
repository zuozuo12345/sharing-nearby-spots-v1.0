package SharingNearbySpots.controller;


import SharingNearbySpots.dto.Result;
import SharingNearbySpots.dto.UserDTO;
import SharingNearbySpots.entity.BlogComments;
import SharingNearbySpots.entity.VoucherOrder;
import SharingNearbySpots.service.IVoucherOrderService;
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

 */
@RestController
@RequestMapping("/voucher-order")
public class VoucherOrderController {

    @Resource
    private IVoucherOrderService voucherOrderService;


    @PostMapping("seckill/{id}")
    public Result seckillVoucher(@PathVariable("id") Long voucherId) {
        return voucherOrderService.seckillVoucher(voucherId);
    }

    @GetMapping("/of/me")
    public Result queryMyVoucherOrder(@RequestParam(value = "current", defaultValue = "1") Integer current) {
        // 获取登录用户
        UserDTO user = UserHolder.getUser();
        // 根据用户查询
        Page<VoucherOrder> page = voucherOrderService.query()
                .eq("user_id", user.getId()).page(new Page<>(current, SystemConstants.MAX_PAGE_SIZE));
        // 获取当前页数据
        List<VoucherOrder> records = page.getRecords();
        return Result.ok(records);
    }
}

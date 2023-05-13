package SharingNearbySpots.service.impl;

import SharingNearbySpots.dto.Result;
import SharingNearbySpots.entity.SeckillVoucher;
import SharingNearbySpots.entity.Voucher;
import SharingNearbySpots.entity.VoucherOrder;
import SharingNearbySpots.mapper.VoucherOrderMapper;
import SharingNearbySpots.service.ISeckillVoucherService;
import SharingNearbySpots.service.IVoucherOrderService;
import SharingNearbySpots.service.IVoucherService;
import SharingNearbySpots.utils.RedisIdWorker;
import SharingNearbySpots.utils.UserHolder;
import com.baomidou.mybatisplus.extension.conditions.query.QueryChainWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.aop.framework.AopContext;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

@Slf4j
@Service
public class VoucherOrderServiceImpl extends ServiceImpl<VoucherOrderMapper, VoucherOrder> implements IVoucherOrderService {

    @Resource
    private ISeckillVoucherService seckillVoucherService;

    @Resource
    private IVoucherService voucherService;

    @Resource
    private RedisIdWorker redisIdWorker;

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    @Resource
    private RedissonClient redissonClient;

    @Override
    public Result seckillVoucher(Long voucherId) {
        //查询优惠券
        SeckillVoucher voucher = seckillVoucherService.getById(voucherId);
        //判断秒杀是否开始
        if(voucher.getBeginTime().isAfter(LocalDateTime.now()))
        { // 还没有开始
            return Result.fail("Not begin yet");
        }
        //判断秒杀是否结束
        if(voucher.getEndTime().isBefore(LocalDateTime.now()))
        { // 还没有开始
            return Result.fail("Alreay finished.");
        }

        //判断库存是否充足
        if (voucher.getStock() < 1)
        {
            return Result.fail("No stocks.");
        }
        Long userId = UserHolder.getUser().getId();

//        synchronized (userId.toString().intern()) {
//            IVoucherOrderService proxy = (IVoucherOrderService) AopContext.currentProxy();
//            return proxy.createVoucherOrder(voucherId);
//        }
        //创建锁对象
//        SimpleRedisLock lock = new SimpleRedisLock("order:" + userId, stringRedisTemplate);

        RLock lock = redissonClient.getLock("lock:order:" + userId);
        //获取锁
        boolean isLock = lock.tryLock();
        if(!isLock)
        {
            //获取失败
            return Result.fail("No repeated Order");

        }
        try {
            IVoucherOrderService proxy = (IVoucherOrderService) AopContext.currentProxy();
            return proxy.createVoucherOrder(voucherId);
        } finally {
           lock.unlock();
        }

    }

    @Transactional
    public Result createVoucherOrder(Long voucherId) {
        // 一人一单
        Long userId = UserHolder.getUser().getId();


            // 查询id
            int count = query().eq("user_id", userId).eq("voucher_id", voucherId).count();
            //判断是否存在
            if(count > 0)
            {
                return Result.fail("Already bought");
            }
            // 扣减库存
            boolean success = seckillVoucherService.update()
                    .setSql("stock = stock - 1")
                    .eq("voucher_id", voucherId)
                    .gt("stock",0)
                    .update();
            if( !success)
            {
                return Result.fail("No stocks.");
            }
            // 创建订单
            VoucherOrder voucherOrder = new VoucherOrder();
            //订单id
            long orderId = redisIdWorker.nextId("order");

        List<Voucher> vouchers = voucherService.query().eq("id", voucherId).list();
        for (Voucher voucher:vouchers) {
            Long shopId = voucher.getShopId();
            String title = voucher.getTitle();
            voucherOrder.setId(orderId);
            //用户id
            voucherOrder.setUserId(userId);
            //代金券id
            voucherOrder.setVoucherId(voucherId);
            voucherOrder.setShopId(shopId);
            voucherOrder.setTitle(title);
            save(voucherOrder);

        }

//        voucherOrder.setId(orderId);
//            //用户id
//            voucherOrder.setUserId(userId);
//            //代金券id
//            voucherOrder.setVoucherId(voucherId);
//
//            save(voucherOrder);

            //返回订单id
            return Result.ok(orderId);

        }


}

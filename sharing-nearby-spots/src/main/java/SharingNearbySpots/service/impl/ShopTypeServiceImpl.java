package SharingNearbySpots.service.impl;

import SharingNearbySpots.dto.Result;
import SharingNearbySpots.entity.ShopType;
import SharingNearbySpots.mapper.ShopTypeMapper;
import SharingNearbySpots.service.IShopTypeService;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *

 */
@Service
public class ShopTypeServiceImpl extends ServiceImpl<ShopTypeMapper, ShopType> implements IShopTypeService {
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Override
    public Result getlist() {
        String key = "cache:typelist";
        //1.在redis中间查询
        List<String> shopTypeList = new ArrayList<>();
        shopTypeList = stringRedisTemplate.opsForList().range(key,0,-1);
        //2.判断是否缓存中了
        //3.中了返回
        if(!shopTypeList.isEmpty()){
            List<ShopType> typeList = new ArrayList<>();
            for (String s:shopTypeList) {
                ShopType shopType = JSONUtil.toBean(s, ShopType.class);
                typeList.add(shopType);
            }
            return Result.ok(typeList);
        }
        //4.没中数据库中查
        List<ShopType> typeList = query().orderByAsc("sort").list();
        //5.不存在直接返回错误
        if(typeList.isEmpty()){
            return Result.fail("不存在分类");
        }
        for(ShopType shopType : typeList){
            String s = JSONUtil.toJsonStr(shopType);
            shopTypeList.add(s);
        }
        //6.存在直接添加进缓存
        stringRedisTemplate.opsForList().rightPushAll(key, shopTypeList);
        return Result.ok(typeList);
    }
}

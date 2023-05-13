package SharingNearbySpots.service.impl;

import SharingNearbySpots.entity.UserInfo;
import SharingNearbySpots.mapper.UserInfoMapper;
import SharingNearbySpots.service.IUserInfoService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *

 */
@Service
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo> implements IUserInfoService {

}

package SharingNearbySpots.service;

import SharingNearbySpots.dto.LoginFormDTO;
import SharingNearbySpots.dto.Result;
import SharingNearbySpots.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * <p>
 *  服务类
 * </p>

 */
public interface IUserService extends IService<User> {



    Result login(LoginFormDTO loginForm, HttpSession session);

    Result sendCode(String phone, HttpSession session);

    Result logout(HttpServletRequest request);

    Result sign();

    Result signCount();
}

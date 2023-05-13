package SharingNearbySpots.utils;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {



    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
/*        //1. 获取请求头中的token
        String token = request.getHeader("authorization");
        if(StrUtil.isBlank(token))
        {
            response.setStatus(401);
            return false;

        }
//        HttpSession session = request.getSession();
        //2.基于token， 获取redis中的用户
//        Object user = session.getAttribute("user");
        String key = RedisConstants.LOGIN_USER_KEY + token;
        Map<Object, Object> userMap = stringRedisTemplate.opsForHash().entries(key);
        //3. 判断用户是否存在
//        if (user == null){
//            //4. 不存在，拦截
//            response.setStatus(401);
//            return false;
//        }

        if(userMap.isEmpty())
        {
            response.setStatus(401);
            return false;
        }
        //4.将查询到的hash转为userDTO
        UserDTO userDTO = BeanUtil.fillBeanWithMap(userMap, new UserDTO(), false);
        //5. 存在 保存用户信息到ThreadLocal
//        UserHolder.saveUser((UserDTO) user);
        UserHolder.saveUser(userDTO);
        //6.刷新token有效期
        stringRedisTemplate.expire(key,RedisConstants.LOGIN_USER_TTL, TimeUnit.MINUTES);*/
        //判断是否需要拦截，threadlocal中是否有用户
        if(UserHolder.getUser() == null)
        {
            response.setStatus(401);
            return false;
        }
        //7. 放行
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        //移除用户
        UserHolder.removeUser();
    }
}

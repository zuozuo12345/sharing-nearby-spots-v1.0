package SharingNearbySpots;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@MapperScan("SharingNearbySpots.mapper")
@EnableAspectJAutoProxy(exposeProxy = true)
@SpringBootApplication
public class SharingNearbySpotsApplication {

    public static void main(String[] args) {
        SpringApplication.run(SharingNearbySpotsApplication.class, args);
    }

}
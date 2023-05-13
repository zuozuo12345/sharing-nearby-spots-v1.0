package SharingNearbySpots.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *

 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("tb_blog_comments")
public class BlogComments implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;


    /**
     * 探店id
     */
    private Long blogId;



    /**
     * 关联的1级评论id，如果是一级评论，则值为0
     */
    private Long parentId;
    private Long answerId;

    /**
     * 回复的评论id
     */

    /**
     * 用户id
     */
    private Long userId;
    /**
     * 用户姓名
     */

    private String nickName;


    private String icon;

//
//
//
//    private Long answerId;
    /**
     * 探店的照片，最多9张，多张以","隔开
     */
    private String images;

    /**
     * 回复的内容
     */
    private String content;

    /**
     * 回复的内容
     */
    private String title;

    /**
     * 点赞数
     */
    private Integer liked;
    /**
     * 点赞数
     */
    @TableField(exist = false)
    private Boolean isLike;

    /**
     * 状态，0：正常，1：被举报，2：禁止查看
     */
    private Boolean status;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 更新时间
     */
    private LocalDateTime updateTime;


}

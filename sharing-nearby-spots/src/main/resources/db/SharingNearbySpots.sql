# test

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_blog
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog`;
CREATE TABLE `tb_blog`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint(20) NOT NULL COMMENT '商户id',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `images` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '探店的照片，最多9张，多张以\",\"隔开',
  `content` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '探店的文字描述',
  `liked` int(8) UNSIGNED NULL DEFAULT 0 COMMENT '点赞数量',
  `comments` int(8) UNSIGNED NULL DEFAULT NULL COMMENT '评论数量',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_blog
-- ----------------------------
INSERT INTO `tb_blog` VALUES (4, 4, 2, 'Artscience Museum, what a wonderful place', '/imgs/blogs/4/10/2f07e3c9-ddce-482d-9ea7-c21450f8d7cd.jpg,/imgs/blogs/2/6/b0756279-65da-4f2d-b62a-33f74b06454a.jpg,/imgs/blogs/10/7/7e97f47d-eb49-4dc9-a583-95faa7aed287.jpg,/imgs/blogs/1/2/4a7b496b-2a08-4af7-aa95-df2c3bd0ef97.jpg,/imgs/blogs/14/3/52b290eb-8b5d-403b-8373-ba0bb856d18e.jpg', 'As the name suggests, ArtScience Museum™ at Marina Bay Sands® beautifully fuses art and science to tell fascinating stories. This premier venue houses a constantly changing line-up of major international touring exhibitions, brought in through collaborations with organisations such as the American Museum of Natural History, the Smithsonian Institute and world-renowned furniture designer Herman Miller.<br/><br/>Where Art meets Science<br/><br/>The ArtScience Museum™ has housed renowned exhibitions that push the boundaries of science, technology and knowledge. “The Deep”, an exhibition on deep-sea life, saw the largest collection of abyssal creatures ever displayed in Southeast Asia, and “The Nobel Prize: Ideas Changing the World” showcased how Nobel Prize-awarded efforts have shaped and continue to change our world.<br/><br/>Other exhibitions at the ArtScience Museum™ have also featured a multitude of works from the Arts and creative fields—from multimedia art pieces by Eric Valli that reflect life along the Yangtze River, to an insight into the art of animation with DreamWorks Animation: The Exhibition.<br/><br/>The museum is also home to the permanent exhibition, FUTURE WORLD: Where Art Meets Science. Visitors can immerse themselves in a dynamic 1,500-square-metre digital universe of interactive art installations revolving around the themes of Nature, Town, Park and Science.<br/>
', 1, 104, '2021-12-28 19:50:01', '2022-03-10 14:26:34');
INSERT INTO `tb_blog` VALUES (5, 1, 2, 'National Museum of Singapore
Singapore’s oldest museum is a progressive showcase of the country’s history and culture', '/imgs/blogs/11/12/8b37d208-9414-4e78-b065-9199647bb3e3.jpg,/imgs/blogs/4/1/fa74a6d6-3026-4cb7-b0b6-35abb1e52d11.jpg,/imgs/blogs/9/12/ac2ce2fb-0605-4f14-82cc-c962b8c86688.jpg,/imgs/blogs/4/0/26a7cd7e-6320-432c-a0b4-1b7418f45ec7.jpg,/imgs/blogs/15/9/cea51d9b-ac15-49f6-b9f1-9cf81e9b9c85.jpg', 'If you have time to visit only one place to learn about the history and culture of Singapore, this is probably it. The National Museum of Singapore tells you the intriguing story of this country in a manner that is both fun and rewarding.<br/><br/>Imagine standing in the midst of a vast darkened space surrounded by a massive video montage showing everyday life in Singapore while a rousing symphony plays in the background. That’s just a taste of the immersive experience you can expect here.<br/><br/>Visitors viewing the exhibitions inside the gallery of the National Museum of Singapore<br/><br/>With its history dating back to 1887, the National Museum of Singapore is the nation’s oldest, and one of the city’s architectural icons. Its permanent offerings, the Singapore Gallery and Life in Singapore: The Past 100 Years galleries, piece together the past and present in a compelling narrative.<br/><br/>The building itself is a wondrous structure that has seamlessly fused the old with the new, enhancing the elegant neo-classical building with a new modernist extension of glass and metal.<br/><br/>', 1, 0, '2021-12-28 20:57:49', '2022-03-10 09:21:39');
INSERT INTO `tb_blog` VALUES (6, 10, 1, 'Have your head in the clouds', '/imgs/blogs/15/9/cea51d9b-ac15-49f6-b9f1-9cf81e9b9c85.jpg', 'Have your head in the clouds', 1, 0, '2022-01-11 16:05:47', '2022-03-10 09:21:41');
INSERT INTO `tb_blog` VALUES (7, 10, 1, 'Have your head in the clouds', '/imgs/blogs/4/0/26a7cd7e-6320-432c-a0b4-1b7418f45ec7.jpg', 'Have your head in the clouds', 1, 0, '2022-01-11 16:05:47', '2022-03-10 09:21:42');

-- ----------------------------
-- Table structure for tb_blog_comments
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog_comments`;
CREATE TABLE `tb_blog_comments`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户id',
  `blog_id` bigint(20) UNSIGNED NOT NULL COMMENT '探店id',
  `parent_id` bigint(20) UNSIGNED NOT NULL COMMENT '关联的1级评论id，如果是一级评论，则值为0',
  `answer_id` bigint(20) UNSIGNED NOT NULL COMMENT '回复的评论id',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '回复的内容',
  `liked` int(8) UNSIGNED NULL DEFAULT NULL COMMENT '点赞数',
  `status` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '状态，0：正常，1：被举报，2：禁止查看',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_blog_comments
-- ----------------------------

-- ----------------------------
-- Table structure for tb_follow
-- ----------------------------
DROP TABLE IF EXISTS `tb_follow`;
CREATE TABLE `tb_follow`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户id',
  `follow_user_id` bigint(20) UNSIGNED NOT NULL COMMENT '关联的用户id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_follow
-- ----------------------------

-- ----------------------------
-- Table structure for tb_seckill_voucher
-- ----------------------------
DROP TABLE IF EXISTS `tb_seckill_voucher`;
CREATE TABLE `tb_seckill_voucher`  (
  `voucher_id` bigint(20) UNSIGNED NOT NULL COMMENT '关联的优惠券的id',
  `stock` int(8) NOT NULL COMMENT '库存',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `begin_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '生效时间',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '失效时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`voucher_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '秒杀优惠券表，与优惠券是一对一关系' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_seckill_voucher
-- ----------------------------
INSERT INTO `tb_seckill_voucher` VALUES (1,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (2,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (3,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (4,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (5,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (6,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (7,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (8,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (9,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (10,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (11,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (12,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (13,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (14,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (15,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (16,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (17,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (18,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (19,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (20,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (21,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (22,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (23,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (24,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (25,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (26,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (27,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (28,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (29,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (30,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (31,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (32,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (33,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (34,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (35,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (36,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (37,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (38,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (39,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (40,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (41,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (42,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (43,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (44,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (45,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (46,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (47,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (48,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (49,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (50,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (51,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (52,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (53,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (54,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (55,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (56,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (57,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (58,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (59,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (60,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (61,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (62,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (63,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (64,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (65,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (66,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (67,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (68,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (69,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (70,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (71,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (72,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (73,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_seckill_voucher` VALUES (74,200, '2023-01-04 09:12:12', '2023-01-04 09:12:12', '2024-01-30 09:12:12', '2023-01-04 10:12:12');

-- ----------------------------
-- Table structure for tb_shop
-- ----------------------------
DROP TABLE IF EXISTS `tb_shop`;
CREATE TABLE `tb_shop`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商铺名称',
  `type_id` bigint(20) UNSIGNED NOT NULL COMMENT '商铺类型的id',
  `images` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商铺图片，多个图片以\',\'隔开',
  `area` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商圈，例如陆家嘴',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址',
  `x` double UNSIGNED NOT NULL COMMENT '经度',
  `y` double UNSIGNED NOT NULL COMMENT '维度',
  `avg_price` bigint(10) UNSIGNED NULL DEFAULT NULL COMMENT '均价，取整数',
  `sold` int(10) UNSIGNED ZEROFILL NOT NULL COMMENT '销量',
  `comments` int(10) UNSIGNED ZEROFILL NOT NULL COMMENT '评论数量',
  `score` int(2) UNSIGNED ZEROFILL NOT NULL COMMENT '评分，1~5分，乘10保存，避免小数',
  `open_hours` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业时间，例如 10:00-22:00',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `foreign_key_type`(`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_shop
-- ----------------------------
INSERT INTO `tb_shop` VALUES (1,'National Museum of Singapore',1,'/imgs/spots/National Museum of Singapore.png','Singapore','93 Stamford Rd, Singapore 178897',103.848637846626,1.29691332880123,80,3,3,37,'10:00-17:00','2021-12-22 18:10:39','2022-01-13 17:32:19');
INSERT INTO `tb_shop` VALUES (2,'Singapore Art Museum',1,'/imgs/spots/Singapore Art Museum.png','Singapore','39 Keppel Rd, #01-02 Tanjong Pagar Distripark, Singapore 089065',103.851556126881,1.29113187883446,85,3,3,46,'11:30-17:00','2021-12-22 19:00:13','2022-01-11 16:12:26');
INSERT INTO `tb_shop` VALUES (3,'National Gallery Singapore',1,'/imgs/spots/National Gallery Singapore.png','Singapore','1 St Andrew Rd,01–01, Singapore 178957',103.851945869227,1.29193777537343,61,3,3,47,'10:30-17:00','2021-12-22 19:10:05','2022-01-11 16:12:42');
INSERT INTO `tb_shop` VALUES (4,'ArtScience Museum',1,'/imgs/spots/ArtScience Museum.png','Singapore','6 Bayfront Ave, Singapore 018974',103.859010008909,1.28893609201147,290,3,3,49,'11:00-18:00','2021-12-22 19:17:15','2022-01-11 16:12:51');
INSERT INTO `tb_shop` VALUES (5,'Asian Civilisations Museum',1,'/imgs/spots/Asian Civilisations Museum.png','Singapore','1 Empress Pl, Singapore 179555',103.85136465749,1.28778114010269,104,3,3,49,'10:00-18:00','2021-12-22 19:20:58','2022-01-11 16:13:01');
INSERT INTO `tb_shop` VALUES (6,'National Design Centre',1,'/imgs/spots/National Design Centre.png','Singapore','111 Middle Rd, Singapore 188969',103.853191837577,1.30081421978379,130,3,3,46,'10:00-17:00','2021-12-22 19:24:53','2022-01-11 16:13:09');
INSERT INTO `tb_shop` VALUES (7,'Singapore Science Centre',1,'/imgs/spots/Singapore Science Centre.png','Singapore','15 Science Centre Rd, Singapore 609081',103.73644033886,1.33985627391967,85,3,3,47,'11:30-17:00','2021-12-22 19:40:52','2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (8,'Lee Kong Chian Natural History Museum',1,'/imgs/spots/Lee Kong Chian Natural History Museum.png','Singapore','2 Conservatory Dr, Singapore 117377',103.772819433604,1.30314416958143,88,3,3,46,'10:30-17:00','2021-12-22 19:51:06','2022-01-11 16:13:25');
INSERT INTO `tb_shop` VALUES (9,'Singapore Botanic Gardens',2,'/imgs/spots/Singapore Botanic Gardens.png','Singapore','1 Cluny Rd, Singapore 259569',103.815999435415,1.3156415678292,101,3,3,44,'11:00-18:00','2021-12-22 19:53:59','2022-01-11 16:13:34');
INSERT INTO `tb_shop` VALUES (10,'Cloud Forest',2,'/imgs/spots/Cloud Forest.png','Singapore','18 Marina Gardens Dr, #03-02/03, Singapore 018953',103.866002400088,1.28408222120039,67,3,3,37,'10:00-18:00','2021-12-22 20:25:16','2021-12-22 20:25:16');
INSERT INTO `tb_shop` VALUES (11,'Flower Dome',2,'/imgs/spots/Flower Dome.png','Singapore','18 Marina Gardens Dr, Singapore 018953',103.864676042429,1.2849188042037,80,3,3,37,'10:00-17:00','2021-12-22 18:10:39','2022-01-13 17:32:19');
INSERT INTO `tb_shop` VALUES (12,'Hort Park',2,'/imgs/spots/Hort Park.png','Singapore','33 Hyderabad Rd, Singapore 119578',103.799986531134,1.2793515623781,85,3,3,46,'11:30-17:00','2021-12-22 19:00:13','2022-01-11 16:12:26');
INSERT INTO `tb_shop` VALUES (13,'Haw Paw villa',2,'/imgs/spots/Haw Paw villa.png','Singapore','262 Pasir Panjang Rd, Singapore 118628',103.781978286783,1.28344870434042,61,3,3,47,'10:30-17:00','2021-12-22 19:10:05','2022-01-11 16:12:42');
INSERT INTO `tb_shop` VALUES (14,'Chestnut Nature Park',2,'/imgs/spots/Chestnut Nature Park.png','Singapore','500 Chestnut Ave',103.778950375954,1.37311015251379,290,3,3,49,'11:00-18:00','2021-12-22 19:17:15','2022-01-11 16:12:51');
INSERT INTO `tb_shop` VALUES (15,'Jewel Canopy Park',2,'/imgs/spots/Jewel Canopy Park.png','Singapore',' 78 Airport Boulevard, Singapore 819666 Singapore.',103.989610257902,1.3603667436116,104,3,3,49,'10:00-18:00','2021-12-22 19:20:58','2022-01-11 16:13:01');
INSERT INTO `tb_shop` VALUES (16,'Shiseido Forest Valley',2,'/imgs/spots/Shiseido Forest Valley.png','Singapore',' 78 Airport Boulevard, Singapore 819666 Singapore',103.989634815641,1.36044044358951,130,3,3,46,'10:00-17:00','2021-12-22 19:40:52','2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (17,'National Library of Singapore',3,'/imgs/spots/National Library of Singapore.png','Singapore','100 Victoria Street Singapore 188064',103.854827124336,1.301964028161,85,3,3,47,'11:30-17:00','2021-12-22 19:40:52','2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (18,'Tamplines Reginal Library',3,'/imgs/spots/Tamplines Reginal Library.png','Singapore','1 Tampines Walk, #02-01 Our Tampines Hub, Singapore 528523',103.941184457897,1.35248764449585,88,3,3,46,'10:30-17:00','2021-12-22 19:51:06','2022-01-11 16:13:25');
INSERT INTO `tb_shop` VALUES (19,' Yishun Public Library',3,'/imgs/spots/Yishun Public Library.png','Singapore','930 Yishun Ave 2 #04-01 North Wing Northpoint City, 769098',103.83637924249,1.42980393766588,101,3,3,44,'11:00-18:00','2021-12-22 19:53:59','2022-01-11 16:13:34');
INSERT INTO `tb_shop` VALUES (20,'Bishan Public Library',3,'/imgs/spots/Bishan Public Library.png','Singapore','5 Bishan Pl, #01-01, Singapore 579841',103.848739884715,1.35014742241311,67,3,3,37,'10:00-18:00','2021-12-22 20:25:16','2021-12-22 20:25:16');
INSERT INTO `tb_shop` VALUES (21,'Woodlands Regional Library',3,'/imgs/spots/Woodlands Regional Library.png','Singapore','900 S Woodlands Dr, #01-03 Civic Centre, Singapore 730900',103.786726355844,1.43519488597895,80,3,3,37,'10:00-17:00','2021-12-22 18:10:39','2022-01-13 17:32:19');
INSERT INTO `tb_shop` VALUES (22,'Marine Parade Library',3,'/imgs/spots/Marine Parade Library.png','Singapore','278 Marine Parade Road #01-02. Singapore 449282 ',103.90949845793,1.30510732790965,85,3,3,46,'11:30-17:00','2021-12-22 19:00:13','2022-01-11 16:12:26');
INSERT INTO `tb_shop` VALUES (23,'Library@Harbourfront',3,'/imgs/spots/Library@Harbourfront.png','Singapore','1 HarbourFront Walk, #03-05 VivoCity, Singapore 098585',103.823377042402,1.26395185411233,61,3,3,47,'10:30-17:00','2021-12-22 19:10:05','2022-01-11 16:12:42');
INSERT INTO `tb_shop` VALUES (24,'Library of Botany and Horticulture',3,'/imgs/spots/Library of Botany and Horticulture.png','Singapore','1 Cluny Rd, Singapore 259569',103.818238586862,1.30878345771733,290,3,3,49,'11:00-18:00','2021-12-22 19:17:15','2022-01-11 16:12:51');
INSERT INTO `tb_shop` VALUES (25,'The Cathay Cineplex',4,'/imgs/spots/The Cathay Cineplex.png','Singapore','321 Clementi Ave 3, #03-03 321, Singapore 129905',103.847517284587,1.29995996769044,104,3,3,49,'10:00-18:00','2021-12-22 19:20:58','2022-01-11 16:13:01');
INSERT INTO `tb_shop` VALUES (26,'Sinema Old School Theatre',4,'/imgs/spots/Oldham Theatre.png','Singapore','2 Kallang Ave, #04-04 CT Hub,Singapore 339407',103.848438879846,1.29438391435575,130,3,3,46,'10:00-17:00','2021-12-22 19:40:52','2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (27,'Golden Village Cinema in VivoCity Mall',4,'/imgs/spots/Golden Village Cinema in VivoCity Mall.png','Singapore','1 HarbourFront Walk, #02-30 VivoCity, Singapore 098585',103.823410013227,1.26689058654666,85,3,3,47,'11:30-17:00','2021-12-22 19:40:52','2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (28,'WE Cinemas',4,'/imgs/spots/WE Cinemas.png','Singapore','321 Clementi Ave 3, #03-03 321, Singapore 129905',103.765090657824,1.31212099273004,88,3,3,46,'10:30-17:00','2021-12-22 19:51:06','2022-01-11 16:13:25');
INSERT INTO `tb_shop` VALUES (29,'The Projector',4,'/imgs/spots/The Projector.png','Singapore','6001 Beach Rd, 05-00 GOLDEN MILE TOWER, Singapore 199589',103.86389698258,1.3022043979517,101,3,3,44,'11:00-18:00','2021-12-22 19:53:59','2022-01-11 16:13:34');
INSERT INTO `tb_shop` VALUES (30,'Shaw Theatres Lido IMAX',4,'/imgs/spots/Shaw Theatres Lido IMAX.png','Singapore','350 Orchard Road 5th, 6th floor Shaw House, Singapore 238868',103.831595471217,1.30568101934908,67,3,3,37,'10:00-18:00','2021-12-22 20:25:16','2021-12-22 20:25:16');
INSERT INTO `tb_shop` VALUES (31,'Carnival Cinemas',4,'/imgs/spots/Carnival Cinemas.png','Singapore','6001, Beach Road ,Golden Mile Tower, Singapore 199589',103.865681562107,1.30577901575769,80,3,3,37,'10:00-17:00','2021-12-22 19:10:05','2022-01-11 16:12:42');
INSERT INTO `tb_shop` VALUES (32,'Eaglewings Cinematics',4,'/imgs/spots/Eaglewings Cinematics.png','Singapore','9 King Albert Park, #01-58 Cinema Box Office Atrium KAP Residences Mall',103.77904968668,1.33711436470285,85,3,3,46,'11:30-17:00','2021-12-22 19:17:15','2022-01-11 16:12:51');
INSERT INTO `tb_shop` VALUES (33,'The Sail',5,'/imgs/spots/The Sail.png','Singapore',' 2, 6 MARINA BOULEVARD',103.852841028994,1.28149999991159,61,3,3,47,'10:30-17:00','2021-12-22 19:20:58','2022-01-11 16:13:01');
INSERT INTO `tb_shop` VALUES (34,'Dou Residences',5,'/imgs/spots/Dou Residences.png','Singapore','1 Fraser St, Singapore 189350',103.858607815609,1.3003492980341,290,3,3,49,'11:00-18:00','2021-12-22 19:40:52','2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (35,'The Crest',5,'/imgs/spots/The Crest.png','Singapore','103 Prince Charles Cres, Singapore 159018',103.819980589023,1.29315136436971,104,3,3,49,'10:00-18:00','2021-12-22 19:40:52','2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (36,'Sky Hbitat',5,'/imgs/spots/Sky Hbitat.png','Singapore','7 Bishan St. 15, Singapore 573908',103.851918073448,1.35258547376364,130,3,3,46,'10:00-17:00','2021-12-22 19:51:06','2022-01-11 16:13:25');
INSERT INTO `tb_shop` VALUES (37,'Ferra',5,'/imgs/spots/Ferra.png','Singapore','1 Leonie Hill, Singapore 239219',103.832547712286,1.30295239360704,85,3,3,47,'11:30-17:00','2021-12-22 19:53:59','2022-01-11 16:13:34');
INSERT INTO `tb_shop` VALUES (38,'The Interlace',5,'/imgs/spots/The Interlace.png','Singapore','180 Depot Rd, #01-02, Singapore 109684',103.803173126956,1.28311640443489,88,3,3,46,'10:30-17:00','2021-12-22 20:25:16','2021-12-22 20:25:16');
INSERT INTO `tb_shop` VALUES (39,'Tree House',5,'/imgs/spots/Tree House.png','Singapore','60 Chestnut Ave, Singapore 679517',103.772636780082,1.39676506932943,101,3,3,44,'11:00-18:00','2021-12-22 18:10:39','2022-01-13 17:32:19');
INSERT INTO `tb_shop` VALUES (40,'Reflections @Keppel Bay',5,'/imgs/spots/Reflections @Keppel Bay.png','Singapore','Keppel Bay View, Singapore 098417',103.8106439558,1.26708825380378,67,3,3,37,'10:00-18:00','2021-12-22 19:00:13','2022-01-11 16:12:26');
INSERT INTO `tb_shop` VALUES (41,'Suntec City Mall',6,'/imgs/spots/Suntec City Mall.png','Singapore','3 Temasek Blvd, #1, #327-328, Singapore 038983',103.858455084421,1.29560673677736,80,3,3,37,'10:00-17:00','2021-12-22 19:10:05','2022-01-11 16:12:42');
INSERT INTO `tb_shop` VALUES (42,'VivoCity',6,'/imgs/spots/VivoCity.png','Singapore','1 HarbourFront Walk, Singapore 098585',103.822142726855,1.2645962704224,85,3,3,46,'11:30-17:00','2021-12-22 19:17:15','2022-01-11 16:12:51');
INSERT INTO `tb_shop` VALUES (43,'ION Orchard',6,'/imgs/spots/ION Orchard.png','Singapore','2 Orchard Turn, Singapore 238801',103.831884826891,1.30415404558595,61,3,3,47,'10:30-17:00','2021-12-22 19:20:58','2022-01-11 16:13:01');
INSERT INTO `tb_shop` VALUES (44,'Shoppes at Marina Bay Sands',6,'/imgs/spots/Shoppes at Marina Bay Sands.png','Singapore','Marina Bay Sands, 10 Bayfront Ave, Singapore 018956, Singapore',103.859493002961,1.28432655386174,290,3,3,49,'11:00-18:00','2021-12-22 19:40:52','2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (45,'Northpoint City',6,'/imgs/spots/Northpoint City.png','Singapore','930 Yishun Ave 2, Singapore 769098',103.835877829158,1.42971246521153,104,3,3,49,'10:00-18:00','2021-12-22 19:40:52','2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (46,'Chinatown Street Market',6,'/imgs/spots/Chinatown Street Market.png','Singapore',' 29 Smith St, Chinatown, Singapore, 058943',103.844168569135,1.2823969952388,130,3,3,46,'10:00-17:00','2021-12-22 19:51:06','2022-01-11 16:13:25');
INSERT INTO `tb_shop` VALUES (47,'Mustafa Center',6,'/imgs/spots/Mustafa Center.png','Singapore','145 Syed Alwi Road, Singapore 207704',103.855468015602,1.31020357100848,85,3,3,47,'11:30-17:00','2021-12-22 19:53:59','2022-01-11 16:13:34');
INSERT INTO `tb_shop` VALUES (48,'Ngee Ann City',6,'/imgs/spots/Ngee Ann City.png','Singapore',' 391A Orchard Rd, Singapore 238873',103.834546542353,1.30277171960812,88,3,3,46,'10:30-17:00','2021-12-22 20:25:16','2021-12-22 20:25:16');
INSERT INTO `tb_shop` VALUES (49,'Mandarin Oriental Singapore',7,'/imgs/spots/Mandarin Oriental Singapore.png','Singapore','5 Raffles Avenue, Marina Square, Singapore 039797',103.858211369218,1.29110810352902,101,3,3,44,'11:00-18:00','2021-12-22 19:10:05','2022-01-11 16:12:42');
INSERT INTO `tb_shop` VALUES (50,' Andaz Singapore',7,'/imgs/spots/Andaz Singapore.png','Singapore','5 Fraser St, Singapore 189354',103.858202386772,1.29954347639227,67,3,3,37,'10:00-18:00','2021-12-22 19:17:15','2022-01-11 16:12:51');
INSERT INTO `tb_shop` VALUES (51,' St. Regis Singapore',7,'/imgs/spots/St. Regis Singapore.png','Singapore','29 Tanglin Rd, Singapore 247911',103.825972398069,1.30627414964267,80,3,3,37,'10:00-17:00','2021-12-22 19:20:58','2022-01-11 16:13:01');
INSERT INTO `tb_shop` VALUES (52,'The Ritz-Carlton, Millenia Singapore',7,'/imgs/spots/The Ritz-Carlton, Millenia Singapore.png','Singapore','Marina Bay 7, Raffles Ave., 039799',103.86009944241,1.29123685122662,85,3,3,46,'11:30-17:00','2021-12-22 19:40:52','2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (53,'Marina Bay Sands Hotel',7,'/imgs/spots/Marina Bay Sands Hotel.png','Singapore','10 Bayfront Ave, Singapore 018956',103.859117228934,1.28395056889415,61,3,3,47,'10:30-17:00','2021-12-22 19:40:52','2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (54,'Six Senses Duxton & Six Senses Maxwell',7,'/imgs/spots/Six Senses Duxton & Six Senses Maxwell.png','Singapore','2 Cook St, Singapore 078857',103.844395500099,1.27909754780088,290,3,3,49,'11:00-18:00','2021-12-22 19:51:06','2022-01-11 16:13:25');
INSERT INTO `tb_shop` VALUES (55,'The Fullerton Hotel Singapore',7,'/imgs/spots/The Fullerton Hotel Singapore.png','Singapore','1 Fullerton Square, Singapore 049178',103.853013455754,1.28657844716606,104,3,3,49,'10:00-18:00','2021-12-22 19:53:59','2022-01-11 16:13:34');
INSERT INTO `tb_shop` VALUES (56,'Capella Singapore',7,'/imgs/spots/Capella Singapore.png','Singapore','1 The Knolls, Sentosa Island, 098297',103.824177429034,1.25001180813802,130,3,3,46,'10:00-17:00','2021-12-22 20:25:16','2021-12-22 20:25:16');
INSERT INTO `tb_shop` VALUES (57,'Changi Airports International',8,'/imgs/spots/Changi Airports International.png','Singapore','60 Airport Boulevard #048-049,Terminal 2',103.988126873367,1.35152181870965,85,3,3,47,'11:30-17:00','2021-12-22 18:10:39','2022-01-13 17:32:19');
INSERT INTO `tb_shop` VALUES (58,'Seletar Airport',8,'/imgs/spots/Seletar Airport.png','Singapore',' 21 Seletar Aerospace Rd 1, Singapore 797405',103.870900942527,1.41527334195527,88,3,3,46,'10:30-17:00','2021-12-22 19:00:13','2022-01-11 16:12:26');
INSERT INTO `tb_shop` VALUES (59,'Pancake Place',9,'/imgs/spots/Pancake Place.png','Singapore','56 Kandahar Street, Singapore 198904',103.860142886694,1.30186551965023,104,3,3,49,'10:00-18:00','2021-12-22 19:53:59','2022-01-11 16:13:34');
INSERT INTO `tb_shop` VALUES (60,'Mr Holmes Bakehouse',9,'/imgs/spots/Mr Holmes Bakehouse.png','Singapore','9 Scotts Road, #01-01/02/03, Pacific Plaza, Singapore 228210',103.832054913513,1.30684479743714,130,3,3,46,'10:00-17:00','2021-12-22 20:25:16','2021-12-22 20:25:16');
INSERT INTO `tb_shop` VALUES (61,'La Vie',9,'/imgs/spots/La Vie.png','Singapore','204 Jalan Besar, Singapore 208890',103.857625511966,1.30923587372286,85,3,3,47,'11:30-17:00','2021-12-22 19:10:05','2022-01-11 16:12:42');
INSERT INTO `tb_shop` VALUES (62,'For The People',9,'/imgs/spots/For The People.png','Singapore','11 Hamilton Road, #01-00, Singapore 209182',103.860846628977,1.31162814485566,88,3,3,46,'10:30-17:00','2021-12-22 19:17:15','2022-01-11 16:12:51');
INSERT INTO `tb_shop` VALUES (63,'Kream & Kensho',9,'/imgs/spots/Kream & Kensho.png','Singapore','35 Kampong Bahru Road, Singapore 169355',103.836411028895,1.2770627646878,101,3,3,44,'11:00-18:00','2021-12-22 19:20:58','2022-01-11 16:13:01');
INSERT INTO `tb_shop` VALUES (64,'Dough',9,'/imgs/spots/Dough.png','Singapore','30 Victoria Street, #01-30, Singapore 187996',103.852122498989,1.29583828700295,67,3,3,37,'10:00-18:00','2021-12-22 19:40:52','2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (65,'Simple Cafe',9,'/imgs/spots/Simple Cafe.png','Singapore','1 West Coast Drive, #01-87, NEWest, Singapore 128020',103.860779729019,1.30516914970823,80,3,3,37,'10:00-17:00','2021-12-22 19:40:52','2022-01-11 16:13:19');
INSERT INTO `tb_shop` VALUES (66,'Bees Knees',9,'/imgs/spots/Bees Knees Urban.png','Singapore','50 Cluny Park Road, Level 1, Botanic Gardens, Singapore 257488',103.850392179457,1.28640563695726,85,3,3,46,'11:30-17:00','2021-12-22 19:51:06','2022-01-11 16:13:25');
INSERT INTO `tb_shop` VALUES (67,'Thian Hock Keng Temple',10,'/imgs/spots/Thian Hock Keng Temple.png','Singapore','158 Telok Ayer Street, Singapore 068613 SG',103.847678315617,1.28119642608759,61,3,3,47,'10:30-17:00','2021-12-22 19:53:59','2022-01-11 16:13:34');
INSERT INTO `tb_shop` VALUES (68,'Buddha Tooth Relic Temple and Museum',10,'/imgs/spots/Buddha Tooth Relic Temple and Museum.png','Singapore','288 South Bridge Road, Singapore 058840',103.844247929056,1.2817963807088,290,3,3,49,'11:00-18:00','2021-12-22 20:25:16','2021-12-22 20:25:16');
INSERT INTO `tb_shop` VALUES (69,'Sri Mariamman Temple',10,'/imgs/spots/Sri Mariamman Temple.png','Singapore','244 South Bridge Road, Singapore 058793 ',103.845199844462,1.28292267358432,104,3,3,49,'10:00-18:00','2021-12-22 18:10:39','2022-01-13 17:32:19');
INSERT INTO `tb_shop` VALUES (70,'Kong Meng San Phor Kark See Monastery',10,'/imgs/spots/Kong Meng San Phor Kark See Monastery.png','Singapore','88 Bright Hill Rd, Singapore 574117',103.835790142413,1.36178564348011,130,3,3,46,'10:00-17:00','2021-12-22 19:00:13','2022-01-11 16:12:26');
INSERT INTO `tb_shop` VALUES (71,'Lian Shan Shuang Lin Temple',10,'/imgs/spots/Lian Shan Shuang Lin Temple.png','Singapore','184 Jalan Toa Payoh, 319944',103.856338782655,1.33020447684679,85,3,3,47,'11:30-17:00','2021-12-22 19:10:05','2022-01-11 16:12:42');
INSERT INTO `tb_shop` VALUES (72,'Burmese Buddhist Temple',10,'/imgs/spots/Burmese Buddhist Temple.png','Singapore','14 Tai Gin Rd, Singapore 327873',103.846821844459,1.32858024326447,88,3,3,46,'10:30-17:00','2021-12-22 19:17:15','2022-01-11 16:12:51');
INSERT INTO `tb_shop` VALUES (73,'Toa Payoh Seu Teck Sean Tong',10,'/imgs/spots/Toa Payoh Seu Teck Sean Tong.png','Singapore','2 Lor 6 Toa Payoh, Singapore 319377',103.851647542381,1.33880396828698,101,3,3,44,'11:00-18:00','2021-12-22 19:20:58','2022-01-11 16:13:01');
INSERT INTO `tb_shop` VALUES (74,'Leong San See',10,'/imgs/spots/Leong San See Temple.png','Singapore','371 Race Course Rd, Singapore 218641',103.85688191535,1.3154704132492,67,3,3,37,'10:00-18:00','2021-12-22 19:40:52','2022-01-11 16:13:19');


-- ----------------------------
-- Table structure for tb_shop_type
-- ----------------------------
DROP TABLE IF EXISTS `tb_shop_type`;
CREATE TABLE `tb_shop_type`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型名称',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `sort` int(3) UNSIGNED NULL DEFAULT NULL COMMENT '顺序',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_shop_type
-- ----------------------------
INSERT INTO `tb_shop_type` VALUES (1, 'Museum', '/types/ms.png', 1, '2021-12-22 20:17:47', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (2, 'Park', '/types/KTV.png', 2, '2021-12-22 20:18:27', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (3, 'Library', '/types/lrmf.png', 3, '2021-12-22 20:18:48', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (4, 'Theater', '/types/jsyd.png', 10, '2021-12-22 20:19:04', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (5, 'Residence', '/types/amzl.png', 5, '2021-12-22 20:19:27', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (6, 'Magamall', '/types/spa.png', 6, '2021-12-22 20:19:35', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (7, 'Hotel', '/types/qzyl.png', 7, '2021-12-22 20:19:53', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (8, 'Airport', '/types/jiuba.png', 8, '2021-12-22 20:20:02', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (9, 'Cafe', '/types/hpg.png', 9, '2021-12-22 20:20:08', '2021-12-23 11:24:31');
INSERT INTO `tb_shop_type` VALUES (10, 'Temple', '/types/mjmj.png', 4, '2021-12-22 20:21:46', '2021-12-23 11:24:31');

-- ----------------------------
-- Table structure for tb_sign
-- ----------------------------
DROP TABLE IF EXISTS `tb_sign`;
CREATE TABLE `tb_sign`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户id',
  `year` year NOT NULL COMMENT '签到的年',
  `month` tinyint(2) NOT NULL COMMENT '签到的月',
  `date` date NOT NULL COMMENT '签到的日期',
  `is_backup` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '是否补签',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_sign
-- ----------------------------

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `phone` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号码',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码，加密存储',
  `nick_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称，默认是用户id',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '人物头像',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniqe_key_phone`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1010 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (1, '13686869696', '', 'Anna', '/imgs/blogs/blog1.jpg', '2021-12-24 10:27:19', '2022-01-11 16:04:00');
INSERT INTO `tb_user` VALUES (2, '13838411438', '', 'Ben', '/imgs/icons/kkjtbcr.jpg', '2021-12-24 15:14:39', '2021-12-28 19:58:04');
INSERT INTO `tb_user` VALUES (4, '13456789011', '', 'Cindy', '', '2022-01-07 12:07:53', '2022-01-07 12:07:53');
INSERT INTO `tb_user` VALUES (5, '13456789001', '', 'Diana', '/imgs/icons/user5-icon.png', '2022-01-07 16:11:33', '2022-03-11 09:09:20');

-- ----------------------------
-- Table structure for tb_user_info
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_info`;
CREATE TABLE `tb_user_info`  (
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '主键，用户id',
  `city` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '城市名称',
  `introduce` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '个人介绍，不要超过128个字符',
  `fans` int(8) UNSIGNED NULL DEFAULT 0 COMMENT '粉丝数量',
  `followee` int(8) UNSIGNED NULL DEFAULT 0 COMMENT '关注的人的数量',
  `gender` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '性别，0：男，1：女',
  `birthday` date NULL DEFAULT NULL COMMENT '生日',
  `credits` int(8) UNSIGNED NULL DEFAULT 0 COMMENT '积分',
  `level` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '会员级别，0~9级,0代表未开通会员',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_user_info
-- ----------------------------

-- ----------------------------
-- Table structure for tb_voucher
-- ----------------------------
DROP TABLE IF EXISTS `tb_voucher`;
CREATE TABLE `tb_voucher`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shop_id` bigint(20) UNSIGNED NULL DEFAULT NULL COMMENT '商铺id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代金券标题',
  `sub_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '副标题',
  `rules` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '使用规则',
  `pay_value` bigint(10) UNSIGNED NOT NULL COMMENT '支付金额，单位是分。例如200代表2元',
  `actual_value` bigint(10) NOT NULL COMMENT '抵扣金额，单位是分。例如200代表2元',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0,普通券；1,秒杀券',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1,上架; 2,下架; 3,过期',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_voucher
-- ----------------------------
INSERT INTO `tb_voucher` VALUES (1,1, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (2,2, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (3,3, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (4,4, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (5,5, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (6,6, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (7,7, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (8,8, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (9,9, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (10,10, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (11,11, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (12,12, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (13,13, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (14,14, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (15,15, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (16,16, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (17,17, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (18,18, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (19,19, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (20,20, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (21,21, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (22,22, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (23,23, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (24,24, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (25,25, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (26,26, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (27,27, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (28,28, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (29,29, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (30,30, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (31,31, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (32,32, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (33,33, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (34,34, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (35,35, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (36,36, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (37,37, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (38,38, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (39,39, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (40,40, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (41,41, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (42,42, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (43,43, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (44,44, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (45,45, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (46,46, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (47,47, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (48,48, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (49,49, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (50,50, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (51,51, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (52,52, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (53,53, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (54,54, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (55,55, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (56,56, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (57,57, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (58,58, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (59,59, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (60,60, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (61,61, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (62,62, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (63,63, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (64,64, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (65,65, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (66,66, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (67,67, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (68,68, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (69,69, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (70,70, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (71,71, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (72,72, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (73,73, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');
INSERT INTO `tb_voucher` VALUES (74,74, '$10 Voucher', 'USE FOR WEEKDAYS', 'Only in shop, no charge',1,1000,1,1, '2023-01-04 09:12:12', '2023-01-04 10:12:12');


-- ----------------------------
-- Table structure for tb_voucher_order
-- ----------------------------
DROP TABLE IF EXISTS `tb_voucher_order`;
CREATE TABLE `tb_voucher_order`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '下单的用户id',
  `voucher_id` bigint(20) UNSIGNED NOT NULL COMMENT '购买的代金券id',
  `pay_type` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '支付方式 1：余额支付；2：支付宝；3：微信',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '订单状态，1：未支付；2：已支付；3：已核销；4：已取消；5：退款中；6：已退款',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  `pay_time` timestamp NULL DEFAULT NULL COMMENT '支付时间',
  `use_time` timestamp NULL DEFAULT NULL COMMENT '核销时间',
  `refund_time` timestamp NULL DEFAULT NULL COMMENT '退款时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_voucher_order
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;

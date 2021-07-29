/*
 Navicat Premium Data Transfer

 Source Server         : MYSQL
 Source Server Type    : MySQL
 Source Server Version : 50540
 Source Host           : localhost:3306
 Source Schema         : mybatis_plus
 Target Server Type    : MySQL
 Target Server Version : 50540
 File Encoding         : 65001

 Date: 18/04/2021 16:44:22
*/
USE mybatis_plus
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for backmess
-- ----------------------------
DROP TABLE IF EXISTS `backmess`;
CREATE TABLE `backmess`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sendname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发送人',
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '回馈信息',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '删除字段',
  `create_time` datetime NULL DEFAULT NULL COMMENT '回馈时间',
  `recivename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接受人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of backmess
-- ----------------------------
INSERT INTO `backmess` VALUES (1, 'admin系统', '<p>你的意见很好，我们已经采用了，后面我们将给你增加一些查询次数作为奖励</p>', 0, '2021-04-13 20:55:18', '小明');
INSERT INTO `backmess` VALUES (2, 'admin系统', '<p><strong>才把他们郁闷郁闷</strong></p>', 0, '2021-04-13 21:00:33', '小明');
INSERT INTO `backmess` VALUES (3, 'qw1', '<p>rghnyjymyt</p>', 0, '2021-04-15 10:33:19', '小明');
INSERT INTO `backmess` VALUES (4, 'admin系统', '<p>大概半年</p>', 0, '2021-04-15 20:56:31', '小明');
INSERT INTO `backmess` VALUES (5, 'admin系统', '<p>没有问题</p>', 1, '2021-04-17 21:05:32', '小明');
INSERT INTO `backmess` VALUES (6, 'admin系统', '<p>成都vvvvbrr</p>', 0, '2021-04-17 21:14:41', '小明');

-- ----------------------------
-- Table structure for hr_company
-- ----------------------------
DROP TABLE IF EXISTS `hr_company`;
CREATE TABLE `hr_company`  (
  `cp_id` int(20) NOT NULL AUTO_INCREMENT COMMENT '部门分类id',
  `cp_name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '部门名字',
  `cp_status` int(11) NOT NULL COMMENT '状态（1：在招聘，2：没有招聘，3：岗位）',
  `cp_level` int(4) NOT NULL COMMENT '层级关系',
  `cp_parent_id` int(20) NULL DEFAULT NULL COMMENT '父分类id',
  `cp_sort` int(20) NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`cp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公司表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hr_company
-- ----------------------------
INSERT INTO `hr_company` VALUES (1, '地区', 1, 0, 0, 0, NULL, '2021-02-20 22:37:29');
INSERT INTO `hr_company` VALUES (2, '北京', 1, 1, 1, 0, NULL, NULL);
INSERT INTO `hr_company` VALUES (3, '四川', 1, 1, 1, 0, NULL, NULL);
INSERT INTO `hr_company` VALUES (4, '朝阳区', 1, 2, 2, 0, NULL, NULL);
INSERT INTO `hr_company` VALUES (5, '北京市区', 1, 2, 2, 0, NULL, NULL);
INSERT INTO `hr_company` VALUES (6, '成都', 1, 2, 3, 0, NULL, NULL);
INSERT INTO `hr_company` VALUES (7, '南充', 1, 2, 3, 0, NULL, NULL);
INSERT INTO `hr_company` VALUES (13, '贵州省', 1, 1, 1, 0, '2021-02-03 14:09:15', '2021-02-03 16:35:50');
INSERT INTO `hr_company` VALUES (15, '贵阳市', 1, 2, 13, 0, '2021-02-03 16:34:22', '2021-02-03 16:34:22');
INSERT INTO `hr_company` VALUES (16, '遵义市', 1, 2, 13, 0, '2021-02-09 14:20:18', '2021-02-09 14:20:18');

-- ----------------------------
-- Table structure for hr_departure
-- ----------------------------
DROP TABLE IF EXISTS `hr_departure`;
CREATE TABLE `hr_departure`  (
  `dp_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `dp_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '员工姓名',
  `dp_instruction` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '离职说明',
  `create_time` datetime NOT NULL COMMENT '入职时间',
  `modify_time` datetime NOT NULL COMMENT '离职时间',
  `dp_employee_status` int(20) NULL DEFAULT NULL COMMENT '员工状态（1：离职）',
  `dp_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话号码',
  `dp_work_time` int(10) NULL DEFAULT NULL COMMENT '工作时间',
  `compid` int(11) NOT NULL COMMENT '公司id',
  `auditstatus` int(1) NOT NULL COMMENT '审核状态',
  `compname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司名称',
  PRIMARY KEY (`dp_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工离职情况表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hr_departure
-- ----------------------------
INSERT INTO `hr_departure` VALUES (1, '分工', '加班太多了，十分累', '2020-10-01 08:00:00', '2021-01-07 08:00:00', 1, '19881700712', 30, 1, 1, 'qw1');
INSERT INTO `hr_departure` VALUES (2, '稳如狗', '不想加班了cdvvf', '2020-10-01 18:02:44', '2020-11-01 18:02:55', 1, '15682341760', 30, 1, 1, 'qw1');
INSERT INTO `hr_departure` VALUES (3, '分工', '我想跳槽', '2020-09-01 18:17:07', '2020-10-01 18:17:17', 1, '1988170712', 30, 1, 1, 'qw1');

-- ----------------------------
-- Table structure for hr_employee
-- ----------------------------
DROP TABLE IF EXISTS `hr_employee`;
CREATE TABLE `hr_employee`  (
  `ep_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `ep_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `ep_sex` int(10) NOT NULL COMMENT '性别(1：男，）',
  `ep_age` tinyint(4) NOT NULL COMMENT '年龄',
  `ep_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话号码',
  `ep_email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `ep_education` int(10) NOT NULL COMMENT '学历（2.本科  1：高中，3：研究生）',
  `ep_job_id` int(10) NULL DEFAULT NULL COMMENT '市区id（ 1：广安 2：南充）',
  `ep_target_pay` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公司名称',
  `ep_introduction` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '个人介绍',
  `ep_empoyee_status` int(11) NOT NULL COMMENT '员工状态（1.录用 2.没有录用，3.正在筛选  4.初步筛选过）',
  `ep_portrait` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工头像',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime NOT NULL COMMENT '更新时间',
  `ep_other` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其他（证明材料，证书等）',
  `ep_is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `ep_sort` int(10) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '排序',
  `ep_job_parent_id` int(10) NULL DEFAULT NULL COMMENT '省份id 1：北京 2：成都）',
  `ep_salary` decimal(10, 2) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '余额',
  `ep_status` int(1) NULL DEFAULT NULL COMMENT '查询状态',
  `ep_upload` int(1) NULL DEFAULT NULL COMMENT '上传数量',
  `ep_message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回馈信息',
  PRIMARY KEY (`ep_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hr_employee
-- ----------------------------
INSERT INTO `hr_employee` VALUES (1, 'qw1', 1, 23, '19881700778', '12346@qq.com', 2, 5, '电器有限公司', 'aaxsdc', 1, 'xdff', '2021-02-02 13:05:03', '2021-02-08 20:12:06', 'assd', 0, 0000000000, 1, 00000002.00, 0, 5, NULL);
INSERT INTO `hr_employee` VALUES (2, '阿萨', 0, 20, '19881707856', '23456@qq.com', 1, 4, '电器有限公司', '<p>ccxvfbg</p>', 2, '', '2021-02-04 11:56:40', '2021-02-08 20:00:00', '<p>vf g g</p>', 0, 0000000001, 1, 00000000.01, 0, 0, NULL);
INSERT INTO `hr_employee` VALUES (3, 'erer', 1, 20, '19881700734', '5678@qq.com', 2, 4, '电器有限公司', 'c  c bf', 3, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-09/a85013a3-0f9d-42de-832b-970fe809bb33_1603275981253.jpg', '2021-02-04 18:16:05', '2021-02-09 20:14:01', '<p>nh h hbb</p>', 1, 0000000000, 1, 00000001.00, 0, 0, NULL);
INSERT INTO `hr_employee` VALUES (4, '稳如狗', 1, 23, '19881700749', '12345788@qq.com', 2, 4, '电器有限公司', '<p>dvdvfv</p>', 2, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-07/d934dee3-73b7-4c0d-8c8c-9c3bcbae99ac_-7f547c09b9e56f0b.jpg', '2021-02-07 18:04:05', '2021-04-16 21:32:20', '<p>dfbfbfba</p>', 0, NULL, 2, 00000002.00, 0, 0, '<p>才不敢方法名</p>');
INSERT INTO `hr_employee` VALUES (9, '王小明', 1, 23, '19881700793', '1234@qq.com', 2, 4, '电器有限公司', '<p><strong>我非常努力</strong></p>', 2, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-09/187419f6-b9ed-4740-89b0-fb7f91ad681f_-7f547c09b9e56f0b.jpg', '2021-02-09 20:11:54', '2021-04-17 21:06:18', '<p><strong>我也是博士生</strong></p>', 0, 0000000000, 2, 00000004.00, 0, 0, '<p>证明不足</p>');
INSERT INTO `hr_employee` VALUES (10, 'world hello', 1, 12, '19881700709', '134325@qq.com', 2, 4, '电器有限公司', '<p><strong>gfhgmhg,jh</strong></p>', 2, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-12/1f728816-7512-4748-8a0f-10dd33be135e_-7f547c09b9e56f0b.jpg', '2021-02-12 13:02:29', '2021-02-12 13:02:29', '<p><strong>fgtghc,j,j,h,</strong></p>', 0, 0000000000, 2, 00000005.00, 0, 0, NULL);
INSERT INTO `hr_employee` VALUES (11, '分工', 0, 23, '19881700712', '1267@qq.com', 2, 7, '电器有限公司', '<p>dxfngfn fxhn</p>', 3, 'https://work-of-recruitment.oss-cn-chengdu.aliyuncs.com/2021-07-29/0fcf344a-279a-4c44-83a2-41d0be1944ec_3B952B531543898AB13E084958D4D70018187316.jpg', '2021-02-12 13:28:14', '2021-02-12 13:28:14', '<p>bdfngfx gfnhng</p>', 0, 0000000000, 3, 00000005.00, 0, 0, NULL);
INSERT INTO `hr_employee` VALUES (12, 'cszvzdfd111111111', 1, 23, '19881700799', '123@qq.com', 2, 4, '电器有限公司', '<p><strong>zrbtz trbzzb</strong></p>', 3, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-03-04/44d6d718-2f21-49dd-8a0c-fb25099d0e66_)_Z]3DIA2KRXKCKUC7PAN6J.JPG', '2021-03-04 21:08:05', '2021-03-04 21:09:22', '<p><strong>&nbsp;xfbfdbbf</strong></p>', 1, 0000000000, 2, 00000005.00, 0, 0, NULL);
INSERT INTO `hr_employee` VALUES (13, 'xcbtbbtr', 1, 45, '19534892345', '123@qq.com', 2, 7, '电器有限公司', '<p><strong>法律的VS改变让你喝牛奶</strong></p>', 3, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-03-16/3810eecd-58ad-42d1-8017-fb6fddcda233_8469171.jpg', '2021-03-16 20:07:32', '2021-03-16 20:07:32', '<p><strong>达成率日本的v热播剧进入</strong></p>', 0, 0000000000, 3, 00000005.00, 0, 0, NULL);
INSERT INTO `hr_employee` VALUES (14, 'fbfnh ', 1, 45, '19881700089', '123@qq.com', 2, 6, '人才公司', '<p><strong>打个比方吧你</strong></p>', 3, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-03-16/90e441cf-2821-42b4-892b-bf96b08a453d_8469171.jpg', '2021-03-16 20:35:35', '2021-03-16 20:35:35', '<p>的v风格的</p>', 0, 0000000000, 3, 00000005.00, 0, 0, NULL);
INSERT INTO `hr_employee` VALUES (15, '小明', 1, 23, '19881700703', '123@qq.com', 2, 6, '成都之家有限公司', '<p><strong>这是一家互联网公司</strong></p>', 1, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-04-17/b9853ce7-61a4-4103-8902-4a17082e6452_Screenshot_20210406-235954.jpg', '2021-04-17 17:36:10', '2021-04-17 17:43:15', '<p>目前处于发展初期</p>', 0, 0000000000, 3, 00000001.00, 1, 0, '');

-- ----------------------------
-- Table structure for hr_images
-- ----------------------------
DROP TABLE IF EXISTS `hr_images`;
CREATE TABLE `hr_images`  (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `images` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证书合集',
  `ep_id` int(4) NULL DEFAULT NULL COMMENT '求职者id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hr_images
-- ----------------------------
INSERT INTO `hr_images` VALUES (9, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-08//b8dde811-949f-484a-82fe-89939ca7c85b_72d3b439aa18c9e2.jpg', 6);
INSERT INTO `hr_images` VALUES (10, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-08//37c2abc2-d6a4-4174-8a55-9ae079c357ae_1603275981253.jpg', 6);
INSERT INTO `hr_images` VALUES (21, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-09//6ee33602-5022-481a-8aba-c2dc27192cf5_1603275981253.jpg', 9);
INSERT INTO `hr_images` VALUES (22, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-09//af00d918-4eec-45d0-8078-9e51ad0e148a_1603276014767.jpg', 9);
INSERT INTO `hr_images` VALUES (24, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-12//54f50726-f2b9-4405-8e48-7108573fe50d_1603276045595.jpg', 10);
INSERT INTO `hr_images` VALUES (25, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-12//3bef0ca7-e59c-4e7a-8f6f-5d13fe57b6b0_72d3b439aa18c9e2.jpg', 11);
INSERT INTO `hr_images` VALUES (32, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-07//6c8161a0-bd73-45fe-8f97-2cf9f63a46a4_72d3b439aa18c9e2.jpg', 4);
INSERT INTO `hr_images` VALUES (33, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-07//b2ab3c5c-2b7c-4241-86d6-e3d78e1ae0ad_1603275981253.jpg', 4);
INSERT INTO `hr_images` VALUES (34, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-03-16//0c5a5db8-1765-413b-843b-942d2ff2cb33_8469171.jpg', 13);
INSERT INTO `hr_images` VALUES (35, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-03-16//3d284e74-7cc4-4f44-8f50-d2d0df97f860_8469171.jpg', 14);
INSERT INTO `hr_images` VALUES (36, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-04-17//7666b940-5ef3-4349-8fb2-510551819425_Screenshot_20201105-184511.jpg', 15);
INSERT INTO `hr_images` VALUES (37, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-04-17//ad957f26-5f96-43f0-8491-1bb952e1ce43_Screenshot_20201107-080424.jpg', 15);

-- ----------------------------
-- Table structure for hr_particulars
-- ----------------------------
DROP TABLE IF EXISTS `hr_particulars`;
CREATE TABLE `hr_particulars`  (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `particualrs` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '重大事件',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(10) NULL DEFAULT 0 COMMENT '逻辑删除',
  `telePhone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `compid` int(11) NULL DEFAULT NULL COMMENT '公司id',
  `auditstatus` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '审核状态',
  `compname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公司名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hr_particulars
-- ----------------------------
INSERT INTO `hr_particulars` VALUES (1, '该员工在酒店管理项目中因玩忽职守造成该项目没有成功上线', '2021-02-23 12:00:04', '2021-02-23 12:00:04', 0, '19881700712', 1, 1, 'qw1');
INSERT INTO `hr_particulars` VALUES (2, ' 该员工在开发项目中因玩忽职守造成工作没有按时完成', '2021-02-23 12:03:45', '2021-02-23 12:03:45', 0, '19881700712', 1, 1, 'qw1');
INSERT INTO `hr_particulars` VALUES (3, '成都市v得到svfbbnny', '2021-02-23 12:09:04', '2021-02-23 12:09:04', 0, '19881700712', 1, 1, 'qw1');
INSERT INTO `hr_particulars` VALUES (4, '方便的方法呢你放心', '2021-02-23 12:10:07', '2021-02-23 12:10:07', 0, '19881700712', 1, 1, 'qw1');
INSERT INTO `hr_particulars` VALUES (5, '市场猜测别人也', '2021-04-10 20:25:11', '2021-04-10 20:25:11', 0, '19881700712', 1, 1, 'qw1');
INSERT INTO `hr_particulars` VALUES (6, '市场猜测别人也', '2021-04-10 20:26:49', '2021-04-10 20:26:49', 1, '19881700712', 1, 1, 'qw1');
INSERT INTO `hr_particulars` VALUES (7, '市场猜测别人也ddfbbg', '2021-03-01 08:00:00', '2021-04-15 08:00:00', 1, '19881700712', 1, 1, 'qw1');
INSERT INTO `hr_particulars` VALUES (8, '市场猜测别人也', '2021-04-11 20:24:34', '2021-04-11 20:24:34', 1, '19881700712', 1, 0, 'qw1');
INSERT INTO `hr_particulars` VALUES (9, '垫付部分那麻烦', '2021-04-14 22:10:50', '2021-04-14 22:10:50', 1, '19881700712', 1, 0, 'qw1');
INSERT INTO `hr_particulars` VALUES (10, '垫付部分那麻烦', '2018-02-02 12:00:04', '2020-12-12 13:00:04', 1, '19881700712', 1, 0, 'qw1');
INSERT INTO `hr_particulars` VALUES (11, '垫付部分那麻烦', '2018-02-02 12:00:04', '2020-12-12 13:00:04', 1, '19881700712', 1, 0, 'qw1');
INSERT INTO `hr_particulars` VALUES (12, '垫付部分那麻烦', '2018-02-02 12:00:04', '2020-12-12 13:00:04', 0, '19881700712', 1, 0, 'qw1');
INSERT INTO `hr_particulars` VALUES (13, '给国防部分别代表', '2021-04-16 20:00:35', '2021-04-16 20:00:35', 1, '19881700712', NULL, 0, NULL);
INSERT INTO `hr_particulars` VALUES (14, '给国防部分别代表', '2021-04-16 20:03:37', '2021-04-16 20:03:37', 0, '19881700712', 1, 1, 'qw1');
INSERT INTO `hr_particulars` VALUES (15, '给国防部分别代表', '2018-02-02 12:00:04', '2020-12-12 13:00:04', 1, '19881700712', 1, 0, 'qw1');
INSERT INTO `hr_particulars` VALUES (16, '给国防部分别代表', '2018-02-02 12:00:04', '2020-12-12 13:00:04', 0, '19881700712', 15, 1, '小明');

-- ----------------------------
-- Table structure for hr_performence
-- ----------------------------
DROP TABLE IF EXISTS `hr_performence`;
CREATE TABLE `hr_performence`  (
  `pf_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `pf_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '员工姓名',
  `pf_attendance` bigint(10) NOT NULL COMMENT '缺勤情况（0:全勤，1：迟到一次）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `pf_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '员工电话号码',
  `compid` int(11) NULL DEFAULT NULL COMMENT '公司id',
  `auditstatus` int(1) NULL DEFAULT NULL COMMENT '审核状态',
  `compname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司名称',
  PRIMARY KEY (`pf_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工工作情况表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hr_performence
-- ----------------------------
INSERT INTO `hr_performence` VALUES (2, '分工', 10, '2021-02-23 17:06:08', '2021-02-23 17:06:08', '19881700712', 1, 1, 'qw1');

-- ----------------------------
-- Table structure for hr_statistics
-- ----------------------------
DROP TABLE IF EXISTS `hr_statistics`;
CREATE TABLE `hr_statistics`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `date_calculated` date NULL DEFAULT NULL COMMENT '统计日期',
  `apply_num` int(10) NULL DEFAULT NULL COMMENT '申请数量',
  `job_id` int(10) NULL DEFAULT NULL COMMENT '岗位id',
  `employee_id` int(10) NULL DEFAULT NULL COMMENT '求职者id',
  `dispin_num` int(10) NULL DEFAULT NULL COMMENT '违纪次数',
  `attend_num` int(10) NULL DEFAULT NULL COMMENT '出勤次数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hr_statistics
-- ----------------------------
INSERT INTO `hr_statistics` VALUES (2, '2021-02-04', 2, 4, NULL, NULL, NULL);
INSERT INTO `hr_statistics` VALUES (8, '2021-02-02', 1, 4, NULL, NULL, NULL);
INSERT INTO `hr_statistics` VALUES (9, '2021-02-03', 3, 4, NULL, NULL, NULL);
INSERT INTO `hr_statistics` VALUES (10, '2021-02-01', 0, 4, NULL, NULL, NULL);
INSERT INTO `hr_statistics` VALUES (11, '2021-02-05', 6, 4, NULL, NULL, NULL);
INSERT INTO `hr_statistics` VALUES (13, '2021-02-08', 1, 4, NULL, NULL, NULL);
INSERT INTO `hr_statistics` VALUES (16, '2021-02-07', 1, 4, NULL, NULL, NULL);
INSERT INTO `hr_statistics` VALUES (17, '2021-02-06', 0, 4, NULL, NULL, NULL);
INSERT INTO `hr_statistics` VALUES (18, '2021-02-09', 0, 4, NULL, NULL, NULL);
INSERT INTO `hr_statistics` VALUES (19, '2021-02-10', 0, 4, NULL, NULL, NULL);
INSERT INTO `hr_statistics` VALUES (20, '2021-03-01', 0, 4, NULL, NULL, NULL);
INSERT INTO `hr_statistics` VALUES (21, '2021-01-01', 0, 7, NULL, NULL, NULL);
INSERT INTO `hr_statistics` VALUES (22, '2021-02-02', 0, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record`  (
  `ep_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `compid` int(10) NOT NULL COMMENT '公司id',
  `ep_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '查询的用户电话号码',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `ep_is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `ep_sort` int(1) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '排序',
  `ep_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '企业老板名称',
  PRIMARY KEY (`ep_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (16, 1, '19881700778', '2021-04-17 15:42:57', 1, 0, 'qw1');
INSERT INTO `record` VALUES (17, 1, '19881700778', '2021-04-17 15:57:16', 0, 0, 'qw1');
INSERT INTO `record` VALUES (18, 15, '19881700703', '2021-04-17 19:42:14', 0, 0, '小明');
INSERT INTO `record` VALUES (19, 15, '19881700703', '2021-04-17 19:42:57', 0, 0, '小明');
INSERT INTO `record` VALUES (20, 15, '19881700703', '2021-04-17 19:51:11', 0, 0, '小明');

-- ----------------------------
-- Table structure for sendmess
-- ----------------------------
DROP TABLE IF EXISTS `sendmess`;
CREATE TABLE `sendmess`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `theme` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '内容',
  `accessory` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `sender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发送人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '发送时间',
  `sendtype` int(1) NULL DEFAULT NULL COMMENT '邮件类型（普通，星级邮件）',
  `sendstatus` int(1) NULL DEFAULT NULL COMMENT '发送状态(0:草稿，1：发送，2：退回）',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sendmess
-- ----------------------------
INSERT INTO `sendmess` VALUES (1, '支付功能优化一下', '支付功能不好看', NULL, 'qw1', '2021-04-12 20:20:03', 0, 3, 0);
INSERT INTO `sendmess` VALUES (2, '都不过分11111', '<p>v给你难道有人</p>', 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-04-12/eff7300a-6b44-434a-8977-a424b359044e_Screenshot_20201210-214616.jpg', 'qw1', '2021-04-12 20:39:42', 1, 3, 0);
INSERT INTO `sendmess` VALUES (3, '我的钱少了', '<p>请看一下后台数据，是否存在这个问题</p>', '', '小明', '2021-04-17 20:14:44', 1, 3, 1);
INSERT INTO `sendmess` VALUES (4, 'qwxc', '<p>sdcdvtbtbtb</p>', '', '小明', '2021-04-17 21:13:39', 0, 3, 0);

-- ----------------------------
-- Table structure for staff
-- ----------------------------
DROP TABLE IF EXISTS `staff`;
CREATE TABLE `staff`  (
  `ep_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `ep_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `ep_sex` int(10) NOT NULL COMMENT '性别(1：男，）',
  `ep_age` tinyint(4) NOT NULL COMMENT '年龄',
  `ep_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话号码',
  `ep_email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `ep_education` int(10) NOT NULL COMMENT '学历（2.本科  1：高中，3：研究生）',
  `ep_introduction` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '申诉原因',
  `ep_empoyee_status` int(1) NOT NULL COMMENT '处理状态（1.已提交 2.审核中，3审核完成  ）',
  `ep_portrait` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工头像',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime NOT NULL COMMENT '更新时间',
  `ep_other` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其他（证明材料，证书等）',
  `ep_is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `ep_sort` int(10) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '排序',
  `ep_message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回馈信息',
  PRIMARY KEY (`ep_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of staff
-- ----------------------------
INSERT INTO `staff` VALUES (1, 'qw1', 1, 23, '19881700778', '12346@qq.com', 2, 'aaxsdc', 3, 'xdff', '2021-02-02 13:05:03', '2021-04-15 21:37:53', 'assd', 1, 0000000000, '<p>的长度不够</p>');
INSERT INTO `staff` VALUES (2, '阿萨', 0, 20, '19881707856', '23456@qq.com', 1, '<p>ccxvfbg</p>', 3, '', '2021-02-04 11:56:40', '2021-02-08 20:00:00', '<p>vf g g</p>', 0, 0000000001, NULL);
INSERT INTO `staff` VALUES (3, 'erer', 1, 20, '19881700734', '5678@qq.com', 2, 'c  c bf', 1, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-09/a85013a3-0f9d-42de-832b-970fe809bb33_1603275981253.jpg', '2021-02-04 18:16:05', '2021-02-09 20:14:01', '<p>nh h hbb</p>', 1, 0000000000, NULL);
INSERT INTO `staff` VALUES (4, '稳如狗', 1, 23, '19881700749', '12345788@qq.com', 2, '<p>dvdvfv</p>', 3, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-07/d934dee3-73b7-4c0d-8c8c-9c3bcbae99ac_-7f547c09b9e56f0b.jpg', '2021-02-07 18:04:05', '2021-04-17 21:07:39', '<p>dfbfbfba</p>', 0, NULL, '<p>证明不足</p>');
INSERT INTO `staff` VALUES (6, 'qw123', 1, 23, '19881700738', '123@qq.com', 2, '<p><strong>cSVF DF&nbsp;&nbsp;</strong></p>', 3, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-08/b30ac198-b059-4ac9-8b54-a916f4a6839b_-7f547c09b9e56f0b.jpg', '2021-02-08 19:17:57', '2021-02-08 19:17:57', '<p><strong>dzzf fbyjx</strong></p>', 0, 0000000000, NULL);
INSERT INTO `staff` VALUES (9, '王小明', 1, 23, '19881700703', '1234@qq.com', 2, '<p><strong>我非常努力</strong></p>', 3, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-09/187419f6-b9ed-4740-89b0-fb7f91ad681f_-7f547c09b9e56f0b.jpg', '2021-02-09 20:11:54', '2021-04-15 21:33:09', '<p><strong>我也是博士生</strong></p>', 0, 0000000000, '<p>现场v发v发vv</p>');
INSERT INTO `staff` VALUES (10, 'world hello', 1, 12, '19881700709', '134325@qq.com', 2, '<p><strong>gfhgmhg,jh</strong></p>', 3, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-12/1f728816-7512-4748-8a0f-10dd33be135e_-7f547c09b9e56f0b.jpg', '2021-02-12 13:02:29', '2021-04-15 21:34:33', '<p><strong>fgtghc,j,j,h,</strong></p>', 0, 0000000000, '<p>地方DVD根本改变</p>');
INSERT INTO `staff` VALUES (11, '分工', 0, 23, '19845678908', '1267@qq.com', 2, '<p>dxfngfn fxhn</p>', 3, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-12/401a66bd-f55a-47a1-82c1-fa9234321583_-7f547c09b9e56f0b.jpg', '2021-02-12 13:28:14', '2021-02-12 13:28:14', '<p>bdfngfx gfnhng</p>', 0, 0000000000, NULL);
INSERT INTO `staff` VALUES (12, 'cszvzdfd111111111', 1, 23, '19881700799', '123@qq.com', 2, '<p><strong>zrbtz trbzzb</strong></p>', 1, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-03-04/44d6d718-2f21-49dd-8a0c-fb25099d0e66_)_Z]3DIA2KRXKCKUC7PAN6J.JPG', '2021-03-04 21:08:05', '2021-03-04 21:09:22', '<p><strong>&nbsp;xfbfdbbf</strong></p>', 1, 0000000000, NULL);
INSERT INTO `staff` VALUES (13, 'aaazzazaz', 0, 23, '19881707777', '123@qq.com', 2, '<p><strong>dgnhgmj</strong>,,.io;.oo.yuu</p>', 3, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-04-15/d51f146c-c3a3-4091-87e8-04af6a08a85a_Screenshot_20200821-194656.jpg', '2021-04-15 19:43:46', '2021-04-15 21:37:09', '<p>dbnum,<strong>ohnnyny</strong></p>', 0, NULL, '<p>市场的v发v</p>');
INSERT INTO `staff` VALUES (14, '剩下的v发v', 1, 23, '19881709922', '123@qq.com', 2, '<p>gbfnh gjmhj</p>', 2, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-04-15/0c6a5656-b6e3-466c-849d-a52cf0ce5d62_IMG_20201127_180944.jpg', '2021-04-15 21:41:09', '2021-04-15 21:41:09', '<p>fdnfhf y</p>', 0, NULL, NULL);

-- ----------------------------
-- Table structure for staff_employee
-- ----------------------------
DROP TABLE IF EXISTS `staff_employee`;
CREATE TABLE `staff_employee`  (
  `ep_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `ep_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `ep_sex` int(10) NOT NULL COMMENT '性别(1：男，）',
  `ep_age` tinyint(4) NOT NULL COMMENT '年龄',
  `ep_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话号码',
  `ep_email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `ep_education` int(10) NOT NULL COMMENT '学历（2.本科  1：高中，3：研究生）',
  `ep_target_pay` int(11) NOT NULL COMMENT '期望薪资',
  `ep_introduction` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '个人介绍',
  `ep_empoyee_status` int(11) NOT NULL COMMENT '员工状态（1.在职 2.离职）',
  `ep_portrait` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工头像',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `modify_time` datetime NOT NULL COMMENT '更新时间',
  `ep_other` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '其他（证明材料，证书等）',
  `ep_is_deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `ep_sort` int(10) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`ep_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '员工表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of staff_employee
-- ----------------------------
INSERT INTO `staff_employee` VALUES (1, 'qw1', 1, 23, '19881700778', '12346@qq.com', 2, 5000, 'aaxsdc', 4, 'xdff', '2021-02-02 13:05:03', '2021-02-08 20:12:06', 'assd', 0, 0000000000);
INSERT INTO `staff_employee` VALUES (2, '阿萨', 0, 20, '19881707856', '23456@qq.com', 1, 4800, '<p>ccxvfbg</p>', 2, '', '2021-02-04 11:56:40', '2021-02-08 20:00:00', '<p>vf g g</p>', 0, 0000000001);
INSERT INTO `staff_employee` VALUES (3, 'erer', 1, 20, '19881700734', '5678@qq.com', 2, 4500, 'c  c bf', 4, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-09/a85013a3-0f9d-42de-832b-970fe809bb33_1603275981253.jpg', '2021-02-04 18:16:05', '2021-02-09 20:14:01', '<p>nh h hbb</p>', 1, 0000000000);
INSERT INTO `staff_employee` VALUES (4, '稳如狗', 1, 23, '19881700749', '12345788@qq.com', 2, 8000, '<p>dvdvfv</p>', 4, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-07/d934dee3-73b7-4c0d-8c8c-9c3bcbae99ac_-7f547c09b9e56f0b.jpg', '2021-02-07 18:04:05', '2021-02-12 13:37:13', '<p>dfbfbfba</p>', 0, NULL);
INSERT INTO `staff_employee` VALUES (6, 'qw123', 1, 23, '19881700738', '123@qq.com', 2, 5000, '<p><strong>cSVF DF&nbsp;&nbsp;</strong></p>', 1, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-08/b30ac198-b059-4ac9-8b54-a916f4a6839b_-7f547c09b9e56f0b.jpg', '2021-02-08 19:17:57', '2021-02-08 19:17:57', '<p><strong>dzzf fbyjx</strong></p>', 0, 0000000000);
INSERT INTO `staff_employee` VALUES (9, '王小明', 1, 23, '19881700703', '1234@qq.com', 2, 8000, '<p><strong>我非常努力</strong></p>', 5, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-09/187419f6-b9ed-4740-89b0-fb7f91ad681f_-7f547c09b9e56f0b.jpg', '2021-02-09 20:11:54', '2021-02-09 20:11:54', '<p><strong>我也是博士生</strong></p>', 0, 0000000000);
INSERT INTO `staff_employee` VALUES (10, 'world hello', 1, 12, '19881700709', '134325@qq.com', 2, 8000, '<p><strong>gfhgmhg,jh</strong></p>', 4, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-12/1f728816-7512-4748-8a0f-10dd33be135e_-7f547c09b9e56f0b.jpg', '2021-02-12 13:02:29', '2021-02-12 13:02:29', '<p><strong>fgtghc,j,j,h,</strong></p>', 0, 0000000000);
INSERT INTO `staff_employee` VALUES (11, '分工', 0, 23, '19845678908', '1267@qq.com', 2, 7000, '<p>dxfngfn fxhn</p>', 4, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-12/401a66bd-f55a-47a1-82c1-fa9234321583_-7f547c09b9e56f0b.jpg', '2021-02-12 13:28:14', '2021-02-12 13:28:14', '<p>bdfngfx gfnhng</p>', 0, 0000000000);
INSERT INTO `staff_employee` VALUES (12, 'cszvzdfd111111111', 1, 23, '19881700799', '123@qq.com', 2, 8000, '<p><strong>zrbtz trbzzb</strong></p>', 5, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-03-04/44d6d718-2f21-49dd-8a0c-fb25099d0e66_)_Z]3DIA2KRXKCKUC7PAN6J.JPG', '2021-03-04 21:08:05', '2021-03-04 21:09:22', '<p><strong>&nbsp;xfbfdbbf</strong></p>', 1, 0000000000);

-- ----------------------------
-- Table structure for staff_images
-- ----------------------------
DROP TABLE IF EXISTS `staff_images`;
CREATE TABLE `staff_images`  (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `images` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证书合集',
  `ep_id` int(4) NULL DEFAULT NULL COMMENT '求职者id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of staff_images
-- ----------------------------
INSERT INTO `staff_images` VALUES (9, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-08//b8dde811-949f-484a-82fe-89939ca7c85b_72d3b439aa18c9e2.jpg', 6);
INSERT INTO `staff_images` VALUES (10, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-08//37c2abc2-d6a4-4174-8a55-9ae079c357ae_1603275981253.jpg', 6);
INSERT INTO `staff_images` VALUES (21, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-09//6ee33602-5022-481a-8aba-c2dc27192cf5_1603275981253.jpg', 9);
INSERT INTO `staff_images` VALUES (22, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-09//af00d918-4eec-45d0-8078-9e51ad0e148a_1603276014767.jpg', 9);
INSERT INTO `staff_images` VALUES (24, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-12//54f50726-f2b9-4405-8e48-7108573fe50d_1603276045595.jpg', 10);
INSERT INTO `staff_images` VALUES (25, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-12//3bef0ca7-e59c-4e7a-8f6f-5d13fe57b6b0_72d3b439aa18c9e2.jpg', 11);
INSERT INTO `staff_images` VALUES (32, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-07//6c8161a0-bd73-45fe-8f97-2cf9f63a46a4_72d3b439aa18c9e2.jpg', 4);
INSERT INTO `staff_images` VALUES (33, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-02-07//b2ab3c5c-2b7c-4241-86d6-e3d78e1ae0ad_1603275981253.jpg', 4);
INSERT INTO `staff_images` VALUES (34, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-03-16//0c5a5db8-1765-413b-843b-942d2ff2cb33_8469171.jpg', 13);
INSERT INTO `staff_images` VALUES (35, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-03-16//3d284e74-7cc4-4f44-8f50-d2d0df97f860_8469171.jpg', 14);
INSERT INTO `staff_images` VALUES (36, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-04-15//628b4ecc-e72e-4632-8141-3ab36a3dd0e7_qq_pic_merged_1603276165261.jpg', 14);

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order`  (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会员名称',
  `mobile` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会员手机',
  `total_fee` decimal(10, 2) NULL DEFAULT 0.01 COMMENT '订单金额（分）',
  `pay_type` tinyint(3) NULL DEFAULT NULL COMMENT '支付类型（1：微信 2：支付宝）',
  `status` tinyint(3) NULL DEFAULT NULL COMMENT '订单状态（0：未支付 1：已支付）',
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ux_order_no`(`order_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '订单' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES (21, '20210409204742042', 'qw1', '19881700778', 0.01, 1, 1, 0, '2021-04-09 20:47:42', '2021-04-09 20:48:00');
INSERT INTO `t_order` VALUES (22, '20210417194125650', '小明', '19881700703', 0.01, 1, 1, 0, '2021-04-17 19:41:25', '2021-04-17 19:41:45');

-- ----------------------------
-- Table structure for t_pay_log
-- ----------------------------
DROP TABLE IF EXISTS `t_pay_log`;
CREATE TABLE `t_pay_log`  (
  `id` char(19) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `order_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '订单号',
  `pay_time` datetime NULL DEFAULT NULL COMMENT '支付完成时间',
  `total_fee` decimal(10, 2) NULL DEFAULT 0.01 COMMENT '支付金额（分）',
  `transaction_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易流水号',
  `trade_state` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易状态',
  `pay_type` tinyint(3) NOT NULL DEFAULT 0 COMMENT '支付类型（1：微信 2：支付宝）',
  `is_deleted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '逻辑删除 1（true）已删除， 0（false）未删除',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_order_no`(`order_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '支付日志表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_pay_log
-- ----------------------------
INSERT INTO `t_pay_log` VALUES ('', '20210409190130103', '2021-04-09 19:02:22', 0.01, '4200000939202104099053896073', 'SUCCESS', 1, 0, '2021-04-09 19:02:22', '2021-04-09 19:02:22');

-- ----------------------------
-- Table structure for upload_images
-- ----------------------------
DROP TABLE IF EXISTS `upload_images`;
CREATE TABLE `upload_images`  (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `images` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证书合集',
  `ep_id` int(4) NULL DEFAULT NULL COMMENT '公司id',
  `create_time` datetime NULL DEFAULT NULL COMMENT '上传时间',
  `ep_status` int(1) NULL DEFAULT NULL COMMENT '审核状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of upload_images
-- ----------------------------
INSERT INTO `upload_images` VALUES (38, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-04-17//ab7ad965-edac-4000-85b1-284de36ec8a6_Screenshot_20201210-214616.jpg', 1, '2021-04-17 17:23:10', 1);
INSERT INTO `upload_images` VALUES (39, 'https://recruitment-work.oss-cn-chengdu.aliyuncs.com/2021-04-17//1a99c7f1-6d00-4925-877a-f21be9529260_IMG_20201127_180944.jpg', 1, '2021-04-17 17:23:11', 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `create_time` datetime NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `version` int(11) NULL DEFAULT NULL COMMENT '版本',
  `deleted` tinyint(1) UNSIGNED NULL DEFAULT NULL COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'Jone', 18, 'test1@baomidou.com', NULL, NULL, NULL, 0);
INSERT INTO `user` VALUES (2, 'Jack', 120, 'test2@baomidou.com', NULL, '2020-11-09 10:32:28', NULL, 0);
INSERT INTO `user` VALUES (3, 'Tom', 28, 'test3@baomidou.com', NULL, NULL, NULL, 0);
INSERT INTO `user` VALUES (4, 'Sandy', 21, 'test4@baomidou.com', NULL, NULL, NULL, 0);
INSERT INTO `user` VALUES (5, 'Billie', 24, 'test5@baomidou.com', NULL, NULL, NULL, 0);
INSERT INTO `user` VALUES (1325625693299572737, 'dffffff', 19, '999999677498@qq.com', '2020-11-09 10:26:08', NULL, NULL, 0);
INSERT INTO `user` VALUES (1325627184303357953, 'aaaaaa', 89, '994444448@qq.com', '2020-11-09 10:32:04', '2020-11-09 10:32:04', NULL, 0);
INSERT INTO `user` VALUES (1325628798271492098, 'bbbbbbb', 120, '994444448@qq.com', '2020-11-09 10:38:29', '2020-11-09 10:41:49', NULL, 0);
INSERT INTO `user` VALUES (1325635071645962242, 'kkkkb', 120, '972286348@qq.com', '2020-11-09 11:03:24', '2020-11-09 11:07:32', 2, 0);
INSERT INTO `user` VALUES (1325715751234969601, 'sssss', 39, '972000008@qq.com', '2020-11-09 16:24:00', '2020-11-09 16:24:00', 1, 1);

-- ----------------------------
-- Table structure for video
-- ----------------------------
DROP TABLE IF EXISTS `video`;
CREATE TABLE `video`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `video_source_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频凭证',
  `video_original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频名称',
  `cp_id` int(11) NULL DEFAULT NULL COMMENT '部门id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of video
-- ----------------------------
INSERT INTO `video` VALUES (18, '8c696449f5864749a782db9d2a7c370c', '销售部宣传视频.mp4', 3);
INSERT INTO `video` VALUES (20, '67a7a8a19e754d1985d2d91171dbbf95', '金融部宣传视频.mp4', 13);
INSERT INTO `video` VALUES (21, 'a9b523ee8f9949b18c231351e523829a', '销售部宣传视频.mp4', 2);

SET FOREIGN_KEY_CHECKS = 1;

/*
 Navicat Premium Data Transfer

 Source Server         : YYF
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : bdm721903566.my3w.com:3306
 Source Schema         : bdm721903566_db

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 08/01/2021 19:28:42
*/

SET NAMES utf8mb4;
updateSET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gtable
-- ----------------------------
-- DROP TABLE IF EXISTS `gtable`;
CREATE TABLE IF NOT EXISTS `gtable` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `table-name` varchar(255) NOT NULL,
  `machine-information` varchar(255) NOT NULL,
  `serial-number` varchar(255) NOT NULL,
  `source-type` varchar(255) NOT NULL DEFAULT '',
  `requests` bigint(20) unsigned NOT NULL,
  `updatetime` varchar(255) NOT NULL DEFAULT '',
  `creattime` varchar(255) NOT NULL DEFAULT '',
  `isactive` varchar(255) NOT NULL DEFAULT '',
  `note` varchar(0) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `m_uuid` (`machine-information`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of gtable
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for information
-- ----------------------------
CREATE TABLE IF NOT EXISTS `information` (
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `serial-number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `table-name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `machine-information` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `date` varchar(20) COLLATE utf8mb4_general_ci DEFAULT '',
  `time` varchar(20) COLLATE utf8mb4_general_ci DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for sinfo
-- ----------------------------
-- DROP TABLE IF EXISTS `sinfo`;
CREATE TABLE IF NOT EXISTS `sinfo` (
  `table-name` varchar(180) NOT NULL DEFAULT '',
  `inrelease-md5` varchar(255) DEFAULT NULL,
  `source-information` text NOT NULL,
  `source-back1` varchar(255) DEFAULT '',
  `source-back2` varchar(255) DEFAULT '',
  `source-back3` varchar(255) DEFAULT '',
  `source-back4` varchar(255) DEFAULT '',
  `source-back5` varchar(255) DEFAULT '',
  `push-list` text,
  `optional-list` text,
  `grayscale-md5` varchar(255) DEFAULT NULL,
  `grayscale-information` text NOT NULL,
  `grayscale-back1` varchar(255) DEFAULT '',
  `grayscale-back2` varchar(255) DEFAULT '',
  `grayscale-back3` varchar(255) DEFAULT '',
  `grayscale-back4` varchar(255) DEFAULT '',
  `grayscale-back5` varchar(255) DEFAULT '',
  `grayscale-key` int(255) NOT NULL,
  `updatetime` varchar(255) NOT NULL DEFAULT '',
  `source-id` varchar(255) NOT NULL DEFAULT '',
  `note` varchar(255) DEFAULT NULL,
  `source_priority` varchar(255) NOT NULL DEFAULT '',
  `grayscale_priority` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`table-name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sinfo
-- ----------------------------
BEGIN;
INSERT INTO `sinfo` VALUES ('default', '', 'deb http://archive.kylinos.cn/kylin/KYLIN-ALL 10.1 main restricted universe multiverse', '', '', '', '', '', 'kylin-installer kylin-recorder kylin-scanner kylin-screenshot kylin-user-guide kylin-video ukui-biometric-manager', 'kylin-activation', '', 'deb http://archive.kylinos.cn/kylin/KYLIN-ALL 10.1 main restricted universe multiverse', '', '', '', '', '', 0, '1609587708', '$2$1$', '','','') ON DUPLICATE KEY UPDATE note='' ;
COMMIT;

-- ----------------------------
-- Table structure for sources
-- ----------------------------
-- DROP TABLE IF EXISTS `sources`;
CREATE TABLE IF NOT EXISTS `sources` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `keyword` varchar(255) NOT NULL DEFAULT '',
  `note` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `source` (`keyword`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sources
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for ssmap
-- ----------------------------
-- DROP TABLE IF EXISTS `ssmap`;
CREATE TABLE IF NOT EXISTS `ssmap` (
  `serial-number` varchar(255) NOT NULL,
  `table-name` varchar(255) NOT NULL DEFAULT '',
  `note` varchar(255) DEFAULT '',
  PRIMARY KEY (`serial-number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of ssmap
-- ----------------------------
BEGIN;
INSERT INTO `ssmap` VALUES ('88888888', 'default', '') ON DUPLICATE KEY UPDATE note='';
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
-- DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `salt` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'root', '476d225af8d770c2d781a7471536c049', '3j98buyy2')  ON DUPLICATE KEY UPDATE username='root';
COMMIT;

-- ----------------------------
-- Records of operation
-- ----------------------------
-- DROP TABLE IF EXISTS `operation_record`;
CREATE TABLE IF NOT EXISTS `operation_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `serial-number` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `table-name` varchar(255) DEFAULT NULL,
  `table-content` varchar(255) DEFAULT NULL,
  `content-before` text DEFAULT NULL,
  `content-after` text DEFAULT NULL,
  `time` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
BEGIN;
COMMIT;

CREATE TABLE IF NOT EXISTS `push_rule` (
  `id` int NOT NULL AUTO_INCREMENT ,
  `kysn` varchar(255) NOT NULL,
  `hw_data` varchar(255) DEFAULT '',
  `hw_data_type` varchar(255) DEFAULT '',
  `hw_type_flag` varchar(255) DEFAULT '',
  `sw_data` varchar(255) DEFAULT '',
  `sinfo_name` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`)
);
BEGIN;
INSERT INTO `push_rule` VALUES(1,"88888888","127.0.0.1$00:50:56:c0:00:08$PF1J2TY5","ip$mac$sn","11100000","v10sp1","default");
COMMIT;

CREATE TABLE IF NOT EXISTS `orgMap` (
  `orgId` varchar(255) NOT NULL ,
  `sinfoName` varchar(255) NOT NULL,
  PRIMARY KEY(`orgId`)
);


CREATE TABLE IF NOT EXISTS `orgInfo` (
  `orgId` varchar(255) NOT NULL ,
  `orgName` varchar(255) NOT NULL,
  `parentId` varchar(255),
  `pathName` varchar(255),
  `pathId` varchar(255),
  PRIMARY KEY(`orgId`)
);


SET FOREIGN_KEY_CHECKS = 1;

SET FOREIGN_KEY_CHECKS = 1;

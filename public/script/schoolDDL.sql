/*
 Navicat Premium Data Transfer

 Source Server         : 172.18.133.135
 Source Server Type    : MySQL
 Source Server Version : 50544
 Source Host           : 172.18.133.135:3306
 Source Schema         : school0001

 Target Server Type    : MySQL
 Target Server Version : 50544
 File Encoding         : 65001

 Date: 17/09/2018 13:58:11
*/

-- ----------------------------
-- Table structure for activities
-- ----------------------------
DROP TABLE IF EXISTS `activities`;
CREATE TABLE `activities`  (
  `activitiesID` int(11) NOT NULL AUTO_INCREMENT,
  `activitiescategoryID` int(11) NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `time_to` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `time_from` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `time_at` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `usertypeID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  PRIMARY KEY (`activitiesID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for activitiescategory
-- ----------------------------
DROP TABLE IF EXISTS `activitiescategory`;
CREATE TABLE `activitiescategory`  (
  `activitiescategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fa_icon` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `schoolyearID` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `userID` int(11) NOT NULL,
  `usertypeID` int(40) NOT NULL,
  PRIMARY KEY (`activitiescategoryID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for activitiescomment
-- ----------------------------
DROP TABLE IF EXISTS `activitiescomment`;
CREATE TABLE `activitiescomment`  (
  `activitiescommentID` int(11) NOT NULL AUTO_INCREMENT,
  `activitiesID` int(11) NOT NULL,
  `comment` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`activitiescommentID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for activitiesmedia
-- ----------------------------
DROP TABLE IF EXISTS `activitiesmedia`;
CREATE TABLE `activitiesmedia`  (
  `activitiesmediaID` int(11) NOT NULL AUTO_INCREMENT,
  `activitiesID` int(11) NOT NULL,
  `attachment` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  PRIMARY KEY (`activitiesmediaID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for activitiesstudent
-- ----------------------------
DROP TABLE IF EXISTS `activitiesstudent`;
CREATE TABLE `activitiesstudent`  (
  `activitiesstudentID` int(11) NOT NULL AUTO_INCREMENT,
  `activitiesID` int(11) NOT NULL,
  `studentID` int(11) NOT NULL,
  `classesID` int(11) NOT NULL,
  PRIMARY KEY (`activitiesstudentID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for alert
-- ----------------------------
DROP TABLE IF EXISTS `alert`;
CREATE TABLE `alert`  (
  `alertID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `itemID` int(128) NOT NULL,
  `userID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `itemname` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`alertID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for asset
-- ----------------------------
DROP TABLE IF EXISTS `asset`;
CREATE TABLE `asset`  (
  `assetID` int(11) NOT NULL AUTO_INCREMENT,
  `serial` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT 'Title',
  `manufacturer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `brand` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `asset_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `asset_condition` int(11) DEFAULT NULL,
  `attachment` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `originalfile` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `asset_categoryID` int(11) DEFAULT NULL,
  `asset_locationID` int(11) DEFAULT NULL,
  `create_date` date NOT NULL,
  `modify_date` date NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_usertypeID` int(11) NOT NULL,
  PRIMARY KEY (`assetID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for asset_assignment
-- ----------------------------
DROP TABLE IF EXISTS `asset_assignment`;
CREATE TABLE `asset_assignment`  (
  `asset_assignmentID` int(11) NOT NULL AUTO_INCREMENT,
  `assetID` int(11) NOT NULL COMMENT 'Description and title',
  `usertypeID` int(11) DEFAULT NULL,
  `check_out_to` int(11) NOT NULL,
  `due_date` date DEFAULT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `assigned_quantity` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `asset_locationID` int(11) DEFAULT NULL,
  `check_out_date` date DEFAULT NULL,
  `check_in_date` date DEFAULT NULL,
  `create_date` date NOT NULL,
  `modify_date` date NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_usertypeID` int(11) NOT NULL,
  PRIMARY KEY (`asset_assignmentID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for asset_category
-- ----------------------------
DROP TABLE IF EXISTS `asset_category`;
CREATE TABLE `asset_category`  (
  `asset_categoryID` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_date` date NOT NULL,
  `modify_date` date NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_usertypeID` int(11) NOT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`asset_categoryID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for assignment
-- ----------------------------
DROP TABLE IF EXISTS `assignment`;
CREATE TABLE `assignment`  (
  `assignmentID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `deadlinedate` date NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `originalfile` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `classesID` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  `sectionID` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `subjectID` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `assignusertypeID` int(11) DEFAULT NULL,
  `assignuserID` int(11) DEFAULT NULL,
  PRIMARY KEY (`assignmentID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for assignmentanswer
-- ----------------------------
DROP TABLE IF EXISTS `assignmentanswer`;
CREATE TABLE `assignmentanswer`  (
  `assignmentanswerID` int(11) NOT NULL AUTO_INCREMENT,
  `assignmentID` int(11) NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  `uploaderID` int(11) NOT NULL,
  `uploadertypeID` int(11) NOT NULL,
  `answerfile` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `answerfileoriginal` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `answerdate` date NOT NULL,
  PRIMARY KEY (`assignmentanswerID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for attendance
-- ----------------------------
DROP TABLE IF EXISTS `attendance`;
CREATE TABLE `attendance`  (
  `attendanceID` int(200) UNSIGNED NOT NULL AUTO_INCREMENT,
  `schoolyearID` int(11) NOT NULL,
  `studentID` int(11) NOT NULL,
  `classesID` int(11) NOT NULL,
  `sectionID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `monthyear` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `a1` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a2` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a3` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a4` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a5` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a6` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a7` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a8` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a9` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a10` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a11` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a12` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a13` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a14` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a15` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a16` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a17` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a18` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a19` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a20` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a21` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a22` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a23` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a24` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a25` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a26` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a27` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a28` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a29` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a30` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a31` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`attendanceID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for automation_rec
-- ----------------------------
DROP TABLE IF EXISTS `automation_rec`;
CREATE TABLE `automation_rec`  (
  `automation_recID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `studentID` int(11) NOT NULL,
  `date` date NOT NULL,
  `day` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `month` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `year` year(4) NOT NULL,
  `nofmodule` int(11) NOT NULL,
  PRIMARY KEY (`automation_recID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for automation_shudulu
-- ----------------------------
DROP TABLE IF EXISTS `automation_shudulu`;
CREATE TABLE `automation_shudulu`  (
  `automation_shuduluID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `day` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `month` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `year` year(4) NOT NULL,
  PRIMARY KEY (`automation_shuduluID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS `book`;
CREATE TABLE `book`  (
  `bookID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `book` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `subject_code` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `due_quantity` int(11) NOT NULL,
  `rack` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`bookID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `categoryID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `hostelID` int(11) NOT NULL,
  `class_type` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `hbalance` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`categoryID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for certificate_template
-- ----------------------------
DROP TABLE IF EXISTS `certificate_template`;
CREATE TABLE `certificate_template`  (
  `certificate_templateID` int(11) NOT NULL AUTO_INCREMENT,
  `usertypeID` int(11) NOT NULL,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `theme` int(11) NOT NULL,
  `top_heading_title` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `top_heading_left` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `top_heading_right` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `top_heading_middle` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `main_middle_text` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `template` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `footer_left_text` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `footer_right_text` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `footer_middle_text` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `background_image` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`certificate_templateID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for childcare
-- ----------------------------
DROP TABLE IF EXISTS `childcare`;
CREATE TABLE `childcare`  (
  `childcareID` int(11) NOT NULL AUTO_INCREMENT,
  `dropped_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `received_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `usertypeID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `parentID` int(11) NOT NULL,
  `signature` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `classesID` int(11) NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  `comment` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `received_status` int(11) NOT NULL DEFAULT 0,
  `receiver_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`childcareID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for classes
-- ----------------------------
DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes`  (
  `classesID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `classes` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `classes_numeric` int(11) NOT NULL,
  `teacherID` int(11) NOT NULL,
  `studentmaxID` int(11) DEFAULT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`classesID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for complain
-- ----------------------------
DROP TABLE IF EXISTS `complain`;
CREATE TABLE `complain`  (
  `complainID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `userID` int(11) DEFAULT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `attachment` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `originalfile` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`complainID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for conversation_msg
-- ----------------------------
DROP TABLE IF EXISTS `conversation_msg`;
CREATE TABLE `conversation_msg`  (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT,
  `conversation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `msg` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attach` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `attach_file_name` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `usertypeID` int(11) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modify_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `start` int(11) DEFAULT NULL,
  PRIMARY KEY (`msg_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for conversation_user
-- ----------------------------
DROP TABLE IF EXISTS `conversation_user`;
CREATE TABLE `conversation_user`  (
  `conversation_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `is_sender` int(11) DEFAULT 0,
  `trash` int(11) DEFAULT 0
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for conversations
-- ----------------------------
DROP TABLE IF EXISTS `conversations`;
CREATE TABLE `conversations`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT 0,
  `draft` int(11) DEFAULT 0,
  `fav_status` int(11) DEFAULT 0,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modify_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for document
-- ----------------------------
DROP TABLE IF EXISTS `document`;
CREATE TABLE `document`  (
  `documentID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_userID` int(11) NOT NULL,
  `create_usertypeID` int(11) NOT NULL,
  PRIMARY KEY (`documentID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eattendance
-- ----------------------------
DROP TABLE IF EXISTS `eattendance`;
CREATE TABLE `eattendance`  (
  `eattendanceID` int(200) UNSIGNED NOT NULL AUTO_INCREMENT,
  `schoolyearID` int(11) NOT NULL,
  `examID` int(11) NOT NULL,
  `classesID` int(11) NOT NULL,
  `sectionID` int(11) NOT NULL,
  `subjectID` int(11) NOT NULL,
  `date` date NOT NULL,
  `studentID` int(11) DEFAULT NULL,
  `s_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `eattendance` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `year` year(4) NOT NULL,
  `eextra` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`eattendanceID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for event
-- ----------------------------
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event`  (
  `eventID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fdate` date NOT NULL,
  `ftime` time NOT NULL,
  `tdate` date NOT NULL,
  `ttime` time NOT NULL,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `details` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `photo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `schoolyearID` int(11) NOT NULL,
  `create_userID` int(11) NOT NULL DEFAULT 0,
  `create_usertypeID` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`eventID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for eventcounter
-- ----------------------------
DROP TABLE IF EXISTS `eventcounter`;
CREATE TABLE `eventcounter`  (
  `eventcounterID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `eventID` int(11) NOT NULL,
  `username` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `photo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` int(11) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`eventcounterID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for exam
-- ----------------------------
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam`  (
  `examID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `exam` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` date NOT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`examID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for examschedule
-- ----------------------------
DROP TABLE IF EXISTS `examschedule`;
CREATE TABLE `examschedule`  (
  `examscheduleID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `examID` int(11) NOT NULL,
  `classesID` int(11) NOT NULL,
  `sectionID` int(11) NOT NULL,
  `subjectID` int(11) NOT NULL,
  `edate` date NOT NULL,
  `examfrom` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `examto` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `room` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `schoolyearID` int(11) NOT NULL,
  PRIMARY KEY (`examscheduleID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for expense
-- ----------------------------
DROP TABLE IF EXISTS `expense`;
CREATE TABLE `expense`  (
  `expenseID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `create_date` date NOT NULL,
  `date` date NOT NULL,
  `expenseday` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expensemonth` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `expenseyear` year(4) NOT NULL,
  `expense` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `amount` double NOT NULL,
  `userID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `uname` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`expenseID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for feetypes
-- ----------------------------
DROP TABLE IF EXISTS `feetypes`;
CREATE TABLE `feetypes`  (
  `feetypesID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `feetypes` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`feetypesID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for fmenu
-- ----------------------------
DROP TABLE IF EXISTS `fmenu`;
CREATE TABLE `fmenu`  (
  `fmenuID` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(11) NOT NULL COMMENT 'Only for active',
  `topbar` int(11) NOT NULL,
  `socal` int(11) NOT NULL,
  PRIMARY KEY (`fmenuID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for fmenu_relation
-- ----------------------------
DROP TABLE IF EXISTS `fmenu_relation`;
CREATE TABLE `fmenu_relation`  (
  `fmenu_relationID` int(11) NOT NULL AUTO_INCREMENT,
  `fmenuID` int(11) DEFAULT NULL,
  `menu_typeID` int(11) DEFAULT NULL COMMENT '1 => Pages, 2 => Post, 3 => Links',
  `menu_parentID` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `menu_orderID` int(11) DEFAULT NULL,
  `menu_pagesID` int(11) DEFAULT NULL,
  `menu_label` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `menu_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`fmenu_relationID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for frontend_setting
-- ----------------------------
DROP TABLE IF EXISTS `frontend_setting`;
CREATE TABLE `frontend_setting`  (
  `fieldoption` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`fieldoption`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for frontend_template
-- ----------------------------
DROP TABLE IF EXISTS `frontend_template`;
CREATE TABLE `frontend_template`  (
  `frontend_templateID` int(11) NOT NULL AUTO_INCREMENT,
  `template_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`frontend_templateID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for globalpayment
-- ----------------------------
DROP TABLE IF EXISTS `globalpayment`;
CREATE TABLE `globalpayment`  (
  `globalpaymentID` int(11) NOT NULL AUTO_INCREMENT,
  `classesID` int(11) DEFAULT NULL,
  `sectionID` int(11) NOT NULL,
  `studentID` int(11) NOT NULL,
  `clearancetype` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `invoicename` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `invoicedescription` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `paymentyear` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  PRIMARY KEY (`globalpaymentID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 124 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for grade
-- ----------------------------
DROP TABLE IF EXISTS `grade`;
CREATE TABLE `grade`  (
  `gradeID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `grade` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `point` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gradefrom` int(11) NOT NULL,
  `gradeupto` int(11) NOT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`gradeID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for hmember
-- ----------------------------
DROP TABLE IF EXISTS `hmember`;
CREATE TABLE `hmember`  (
  `hmemberID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `hostelID` int(11) NOT NULL,
  `categoryID` int(11) NOT NULL,
  `studentID` int(11) NOT NULL,
  `hbalance` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `hjoindate` date NOT NULL,
  PRIMARY KEY (`hmemberID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for holiday
-- ----------------------------
DROP TABLE IF EXISTS `holiday`;
CREATE TABLE `holiday`  (
  `holidayID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `schoolyearID` int(11) NOT NULL,
  `fdate` date NOT NULL,
  `tdate` date NOT NULL,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `details` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `photo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_userID` int(11) NOT NULL DEFAULT 0,
  `create_usertypeID` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`holidayID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for hostel
-- ----------------------------
DROP TABLE IF EXISTS `hostel`;
CREATE TABLE `hostel`  (
  `hostelID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `htype` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`hostelID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for hourly_template
-- ----------------------------
DROP TABLE IF EXISTS `hourly_template`;
CREATE TABLE `hourly_template`  (
  `hourly_templateID` int(11) NOT NULL AUTO_INCREMENT,
  `hourly_grades` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `hourly_rate` int(11) NOT NULL,
  PRIMARY KEY (`hourly_templateID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for idmanager
-- ----------------------------
DROP TABLE IF EXISTS `idmanager`;
CREATE TABLE `idmanager`  (
  `idmanagerID` int(11) NOT NULL AUTO_INCREMENT,
  `schooltype` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `idtitle` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `idtype` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`idmanagerID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for income
-- ----------------------------
DROP TABLE IF EXISTS `income`;
CREATE TABLE `income`  (
  `incomeID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `date` date NOT NULL,
  `incomeday` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `incomemonth` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `incomeyear` year(4) NOT NULL,
  `amount` double NOT NULL,
  `file` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  `create_date` date NOT NULL,
  `userID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  PRIMARY KEY (`incomeID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for instruction
-- ----------------------------
DROP TABLE IF EXISTS `instruction`;
CREATE TABLE `instruction`  (
  `instructionID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`instructionID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for invoice
-- ----------------------------
DROP TABLE IF EXISTS `invoice`;
CREATE TABLE `invoice`  (
  `invoiceID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `schoolyearID` int(11) NOT NULL,
  `classesID` int(11) NOT NULL,
  `studentID` int(11) NOT NULL,
  `feetypeID` int(11) DEFAULT NULL,
  `feetype` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `amount` double NOT NULL,
  `discount` double NOT NULL DEFAULT 0,
  `userID` int(11) DEFAULT NULL,
  `usertypeID` int(11) DEFAULT NULL,
  `uname` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `date` date NOT NULL,
  `create_date` date NOT NULL,
  `day` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `month` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `year` year(4) NOT NULL,
  `paidstatus` int(11) DEFAULT NULL,
  `deleted_at` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`invoiceID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for issue
-- ----------------------------
DROP TABLE IF EXISTS `issue`;
CREATE TABLE `issue`  (
  `issueID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `lID` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bookID` int(11) NOT NULL,
  `serial_no` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `issue_date` date NOT NULL,
  `due_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`issueID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for leaveapp
-- ----------------------------
DROP TABLE IF EXISTS `leaveapp`;
CREATE TABLE `leaveapp`  (
  `leaveID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fdate` date NOT NULL,
  `tdate` date NOT NULL,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `details` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `touserID` int(11) NOT NULL,
  `tousertypeID` int(11) NOT NULL,
  `fromuserID` int(11) NOT NULL,
  `fromusertypeID` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `schoolyearID` int(11) NOT NULL,
  PRIMARY KEY (`leaveID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for lmember
-- ----------------------------
DROP TABLE IF EXISTS `lmember`;
CREATE TABLE `lmember`  (
  `lmemberID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `lID` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `studentID` int(11) NOT NULL,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phone` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `lbalance` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ljoindate` date NOT NULL,
  PRIMARY KEY (`lmemberID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for location
-- ----------------------------
DROP TABLE IF EXISTS `location`;
CREATE TABLE `location`  (
  `locationID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `location` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `create_date` date NOT NULL,
  `modify_date` date NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_usertypeID` int(11) NOT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`locationID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for mailandsms
-- ----------------------------
DROP TABLE IF EXISTS `mailandsms`;
CREATE TABLE `mailandsms`  (
  `mailandsmsID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `usertypeID` int(11) NOT NULL,
  `users` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `senderusertypeID` int(11) NOT NULL,
  `senderID` int(11) NOT NULL,
  `message` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `year` year(4) NOT NULL,
  PRIMARY KEY (`mailandsmsID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for mailandsmstemplate
-- ----------------------------
DROP TABLE IF EXISTS `mailandsmstemplate`;
CREATE TABLE `mailandsmstemplate`  (
  `mailandsmstemplateID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `template` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mailandsmstemplateID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for mailandsmstemplatetag
-- ----------------------------
DROP TABLE IF EXISTS `mailandsmstemplatetag`;
CREATE TABLE `mailandsmstemplatetag`  (
  `mailandsmstemplatetagID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `usertypeID` int(11) NOT NULL,
  `tagname` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mailandsmstemplatetag_extra` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mailandsmstemplatetagID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for make_payment
-- ----------------------------
DROP TABLE IF EXISTS `make_payment`;
CREATE TABLE `make_payment`  (
  `make_paymentID` int(11) NOT NULL AUTO_INCREMENT,
  `month` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `gross_salary` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `total_deduction` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `net_salary` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `payment_amount` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `payment_method` int(11) NOT NULL,
  `comments` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `templateID` int(11) NOT NULL,
  `salaryID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `schoolyearID` int(11) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `total_hours` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`make_paymentID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for manage_salary
-- ----------------------------
DROP TABLE IF EXISTS `manage_salary`;
CREATE TABLE `manage_salary`  (
  `manage_salaryID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `salary` int(11) NOT NULL,
  `template` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`manage_salaryID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for mark
-- ----------------------------
DROP TABLE IF EXISTS `mark`;
CREATE TABLE `mark`  (
  `markID` int(200) UNSIGNED NOT NULL AUTO_INCREMENT,
  `schoolyearID` int(11) NOT NULL,
  `examID` int(11) NOT NULL,
  `exam` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `studentID` int(11) NOT NULL,
  `classesID` int(11) NOT NULL,
  `subjectID` int(11) NOT NULL,
  `subject` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `year` year(4) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_userID` int(11) NOT NULL DEFAULT 0,
  `create_usertypeID` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`markID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for markpercentage
-- ----------------------------
DROP TABLE IF EXISTS `markpercentage`;
CREATE TABLE `markpercentage`  (
  `markpercentageID` int(11) NOT NULL AUTO_INCREMENT,
  `markpercentagetype` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `percentage` double NOT NULL,
  `examID` int(11) DEFAULT NULL,
  `classesID` int(11) DEFAULT NULL,
  `subjectID` int(11) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`markpercentageID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for markrelation
-- ----------------------------
DROP TABLE IF EXISTS `markrelation`;
CREATE TABLE `markrelation`  (
  `markrelationID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `markID` int(11) NOT NULL,
  `markpercentageID` int(11) NOT NULL,
  `mark` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`markrelationID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 209 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for media
-- ----------------------------
DROP TABLE IF EXISTS `media`;
CREATE TABLE `media`  (
  `mediaID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `mcategoryID` int(11) NOT NULL DEFAULT 0,
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file_name_display` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`mediaID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for media_category
-- ----------------------------
DROP TABLE IF EXISTS `media_category`;
CREATE TABLE `media_category`  (
  `mcategoryID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `folder_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mcategoryID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for media_gallery
-- ----------------------------
DROP TABLE IF EXISTS `media_gallery`;
CREATE TABLE `media_gallery`  (
  `media_galleryID` int(11) NOT NULL AUTO_INCREMENT,
  `media_gallery_type` int(11) NOT NULL,
  `file_type` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `file_original_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `file_title` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file_size` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `file_width_height` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `file_upload_date` datetime DEFAULT NULL,
  `file_caption` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `file_alt_text` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `file_description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `file_length` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `file_artist` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `file_album` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`media_galleryID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for media_share
-- ----------------------------
DROP TABLE IF EXISTS `media_share`;
CREATE TABLE `media_share`  (
  `shareID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `classesID` int(11) NOT NULL DEFAULT 0,
  `public` int(11) NOT NULL,
  `file_or_folder` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`shareID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `menuID` int(11) NOT NULL AUTO_INCREMENT,
  `menuName` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `link` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `icon` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `pullRight` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `status` int(11) NOT NULL DEFAULT 1,
  `parentID` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) NOT NULL DEFAULT 1000,
  PRIMARY KEY (`menuID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 122 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `messageID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `receiverID` int(11) NOT NULL,
  `receiverType` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `message` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `attach` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `attach_file_name` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `userID` int(11) NOT NULL,
  `usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `useremail` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `year` year(4) NOT NULL,
  `date` date NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `read_status` tinyint(1) NOT NULL,
  `from_status` int(11) NOT NULL,
  `to_status` int(11) NOT NULL,
  `fav_status` tinyint(1) NOT NULL,
  `fav_status_sent` tinyint(1) NOT NULL,
  `reply_status` int(11) NOT NULL,
  PRIMARY KEY (`messageID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `version` int(3) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for mobile_permission_relationships
-- ----------------------------
DROP TABLE IF EXISTS `mobile_permission_relationships`;
CREATE TABLE `mobile_permission_relationships`  (
  `permission_id` int(11) NOT NULL,
  `usertype_id` int(11) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `noticeID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `notice` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  `date` date NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_userID` int(11) NOT NULL DEFAULT 0,
  `create_usertypeID` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`noticeID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for online_exam
-- ----------------------------
DROP TABLE IF EXISTS `online_exam`;
CREATE TABLE `online_exam`  (
  `onlineExamID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `classID` int(11) DEFAULT 0,
  `sectionID` int(11) DEFAULT 0,
  `studentGroupID` int(11) DEFAULT 0,
  `subjectID` int(11) DEFAULT 0,
  `userTypeID` int(11) DEFAULT 0,
  `instructionID` int(11) DEFAULT 0,
  `schoolYearID` int(11) NOT NULL,
  `examTypeNumber` int(11) DEFAULT NULL,
  `startDateTime` datetime DEFAULT NULL,
  `endDateTime` datetime DEFAULT NULL,
  `duration` int(11) DEFAULT 0,
  `random` int(11) DEFAULT 0,
  `public` int(11) DEFAULT 0,
  `status` int(11) DEFAULT 1,
  `markType` int(11) NOT NULL,
  `negativeMark` int(11) DEFAULT 0,
  `bonusMark` int(11) DEFAULT 0,
  `point` int(11) DEFAULT 0,
  `percentage` int(11) DEFAULT 0,
  `showMarkAfterExam` int(11) DEFAULT 0,
  `judge` int(11) DEFAULT 1 COMMENT 'Auto Judge = 1, Manually Judge = 0',
  `paid` int(11) DEFAULT 0 COMMENT '0 = Unpaid, 1 = Paid',
  `validDays` int(11) DEFAULT 0,
  `cost` int(11) DEFAULT 0,
  `img` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_usertypeID` int(11) NOT NULL,
  PRIMARY KEY (`onlineExamID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for online_exam_question
-- ----------------------------
DROP TABLE IF EXISTS `online_exam_question`;
CREATE TABLE `online_exam_question`  (
  `onlineExamQuestionID` int(11) NOT NULL AUTO_INCREMENT,
  `onlineExamID` int(11) NOT NULL,
  `questionID` int(11) DEFAULT NULL,
  PRIMARY KEY (`onlineExamQuestionID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for online_exam_type
-- ----------------------------
DROP TABLE IF EXISTS `online_exam_type`;
CREATE TABLE `online_exam_type`  (
  `onlineExamTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `examTypeNumber` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT 1,
  PRIMARY KEY (`onlineExamTypeID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for online_exam_user_answer
-- ----------------------------
DROP TABLE IF EXISTS `online_exam_user_answer`;
CREATE TABLE `online_exam_user_answer`  (
  `onlineExamUserAnswerID` int(11) NOT NULL AUTO_INCREMENT,
  `onlineExamQuestionID` int(11) NOT NULL,
  `onlineExamRegisteredUserID` int(11) DEFAULT NULL,
  `userID` int(11) DEFAULT NULL,
  PRIMARY KEY (`onlineExamUserAnswerID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for online_exam_user_answer_option
-- ----------------------------
DROP TABLE IF EXISTS `online_exam_user_answer_option`;
CREATE TABLE `online_exam_user_answer_option`  (
  `onlineExamUserAnswerOptionID` int(11) NOT NULL AUTO_INCREMENT,
  `questionID` int(11) NOT NULL,
  `optionID` int(11) DEFAULT NULL,
  `typeID` int(11) NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `time` datetime NOT NULL,
  PRIMARY KEY (`onlineExamUserAnswerOptionID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for online_exam_user_status
-- ----------------------------
DROP TABLE IF EXISTS `online_exam_user_status`;
CREATE TABLE `online_exam_user_status`  (
  `onlineExamUserStatus` int(11) NOT NULL AUTO_INCREMENT,
  `onlineExamID` int(11) NOT NULL,
  `duration` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `totalQuestion` int(11) NOT NULL,
  `totalAnswer` int(11) NOT NULL,
  `nagetiveMark` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `userID` int(11) NOT NULL,
  `classesID` int(11) DEFAULT NULL,
  `sectionID` int(11) DEFAULT NULL,
  `examtimeID` int(11) DEFAULT NULL,
  `totalCurrectAnswer` int(11) DEFAULT NULL,
  `totalMark` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `totalObtainedMark` int(11) DEFAULT NULL,
  `totalPercentage` int(11) DEFAULT NULL,
  `statusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`onlineExamUserStatus`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for pages
-- ----------------------------
DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages`  (
  `pagesID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `url` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `status` int(11) DEFAULT NULL COMMENT '1 => active, 2 => draft, 3 => trash, 4 => review  ',
  `visibility` int(11) DEFAULT NULL COMMENT '1 => public 2 => protected 3 => private ',
  `publish_date` datetime DEFAULT NULL,
  `parentID` int(11) NOT NULL DEFAULT 0,
  `pageorder` int(11) NOT NULL DEFAULT 0,
  `template` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `featured_image` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `modify_date` datetime DEFAULT NULL,
  `create_userID` int(11) DEFAULT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `password` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`pagesID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for parents
-- ----------------------------
DROP TABLE IF EXISTS `parents`;
CREATE TABLE `parents`  (
  `parentsID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `father_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mother_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `father_profession` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mother_profession` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phone` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `address` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `photo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `username` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`parentsID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment`  (
  `paymentID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `schoolyearID` int(11) NOT NULL,
  `invoiceID` int(11) NOT NULL,
  `studentID` int(11) NOT NULL,
  `paymentamount` double DEFAULT NULL,
  `paymenttype` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `paymentdate` date NOT NULL,
  `paymentday` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `paymentmonth` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `paymentyear` year(4) NOT NULL,
  `userID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `uname` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `transactionID` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `globalpaymentID` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`paymentID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 114 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for permission_relationships
-- ----------------------------
DROP TABLE IF EXISTS `permission_relationships`;
CREATE TABLE `permission_relationships`  (
  `permission_id` int(11) NOT NULL,
  `usertype_id` int(11) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `permissionID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'In most cases, this should be the name of the module (e.g. news)',
  `active` enum('yes','no') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`permissionID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 807 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts`  (
  `postsID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `url` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `status` int(11) DEFAULT NULL COMMENT '1 => active, 2 => draft, 3 => trash, 4 => review  ',
  `visibility` int(11) DEFAULT NULL COMMENT '1 => public 2 => protected 3 => private ',
  `publish_date` datetime DEFAULT NULL,
  `parentID` int(11) NOT NULL DEFAULT 0,
  `postorder` int(11) NOT NULL DEFAULT 0,
  `featured_image` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `modify_date` datetime DEFAULT NULL,
  `create_userID` int(11) DEFAULT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `password` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`postsID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for posts_categories
-- ----------------------------
DROP TABLE IF EXISTS `posts_categories`;
CREATE TABLE `posts_categories`  (
  `posts_categoriesID` int(11) NOT NULL AUTO_INCREMENT,
  `posts_categories` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `posts_slug` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `posts_parent` int(11) DEFAULT 0,
  `posts_description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`posts_categoriesID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for posts_category
-- ----------------------------
DROP TABLE IF EXISTS `posts_category`;
CREATE TABLE `posts_category`  (
  `posts_categoryID` int(11) NOT NULL AUTO_INCREMENT,
  `postsID` int(11) NOT NULL,
  `posts_categoriesID` int(11) NOT NULL,
  PRIMARY KEY (`posts_categoryID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for promotionlog
-- ----------------------------
DROP TABLE IF EXISTS `promotionlog`;
CREATE TABLE `promotionlog`  (
  `promotionLogID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `promotionType` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `classesID` int(11) NOT NULL,
  `jumpClassID` int(11) NOT NULL,
  `schoolYearID` int(11) NOT NULL,
  `jumpSchoolYearID` int(11) NOT NULL,
  `subjectandsubjectcodeandmark` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `exams` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `markpercentages` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `promoteStudents` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  PRIMARY KEY (`promotionLogID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for purchase
-- ----------------------------
DROP TABLE IF EXISTS `purchase`;
CREATE TABLE `purchase`  (
  `purchaseID` int(11) NOT NULL AUTO_INCREMENT,
  `assetID` int(11) NOT NULL,
  `vendorID` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit` int(11) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `service_date` date DEFAULT NULL,
  `purchase_price` double NOT NULL,
  `purchased_by` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `expire_date` date DEFAULT NULL,
  `create_date` date NOT NULL,
  `modify_date` date NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_usertypeID` int(11) NOT NULL,
  PRIMARY KEY (`purchaseID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for question_answer
-- ----------------------------
DROP TABLE IF EXISTS `question_answer`;
CREATE TABLE `question_answer`  (
  `answerID` int(11) NOT NULL AUTO_INCREMENT,
  `questionID` int(11) NOT NULL,
  `optionID` int(11) DEFAULT NULL,
  `typeNumber` int(11) NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`answerID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for question_bank
-- ----------------------------
DROP TABLE IF EXISTS `question_bank`;
CREATE TABLE `question_bank`  (
  `questionBankID` int(11) NOT NULL AUTO_INCREMENT,
  `question` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `explanation` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `levelID` int(11) DEFAULT NULL,
  `groupID` int(11) DEFAULT NULL,
  `totalQuestion` int(11) DEFAULT 0,
  `totalOption` int(11) DEFAULT NULL,
  `typeNumber` int(11) DEFAULT NULL,
  `parentID` int(11) DEFAULT 0,
  `time` int(11) DEFAULT 0,
  `mark` int(11) DEFAULT 0,
  `hints` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `upload` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `subjectID` int(11) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_usertypeID` int(11) NOT NULL,
  PRIMARY KEY (`questionBankID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for question_group
-- ----------------------------
DROP TABLE IF EXISTS `question_group`;
CREATE TABLE `question_group`  (
  `questionGroupID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`questionGroupID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for question_level
-- ----------------------------
DROP TABLE IF EXISTS `question_level`;
CREATE TABLE `question_level`  (
  `questionLevelID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`questionLevelID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for question_option
-- ----------------------------
DROP TABLE IF EXISTS `question_option`;
CREATE TABLE `question_option`  (
  `optionID` int(11) NOT NULL AUTO_INCREMENT,
  `questionID` int(11) NOT NULL,
  `name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `img` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`optionID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for question_type
-- ----------------------------
DROP TABLE IF EXISTS `question_type`;
CREATE TABLE `question_type`  (
  `questionTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `typeNumber` int(11) NOT NULL,
  `name` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`questionTypeID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for reply_msg
-- ----------------------------
DROP TABLE IF EXISTS `reply_msg`;
CREATE TABLE `reply_msg`  (
  `replyID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `messageID` int(11) NOT NULL,
  `reply_msg` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`replyID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for reset
-- ----------------------------
DROP TABLE IF EXISTS `reset`;
CREATE TABLE `reset`  (
  `resetID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `keyID` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`resetID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for routine
-- ----------------------------
DROP TABLE IF EXISTS `routine`;
CREATE TABLE `routine`  (
  `routineID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `classesID` int(11) NOT NULL,
  `sectionID` int(11) NOT NULL,
  `subjectID` int(11) NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  `teacherID` int(11) NOT NULL,
  `day` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `start_time` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `end_time` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `room` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`routineID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for salary_option
-- ----------------------------
DROP TABLE IF EXISTS `salary_option`;
CREATE TABLE `salary_option`  (
  `salary_optionID` int(11) NOT NULL AUTO_INCREMENT,
  `salary_templateID` int(11) NOT NULL,
  `option_type` int(11) NOT NULL COMMENT 'Allowances =1, Dllowances = 2, Increment = 3',
  `label_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `label_amount` double NOT NULL,
  PRIMARY KEY (`salary_optionID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for salary_template
-- ----------------------------
DROP TABLE IF EXISTS `salary_template`;
CREATE TABLE `salary_template`  (
  `salary_templateID` int(11) NOT NULL AUTO_INCREMENT,
  `salary_grades` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `basic_salary` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `overtime_rate` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`salary_templateID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for schoolyear
-- ----------------------------
DROP TABLE IF EXISTS `schoolyear`;
CREATE TABLE `schoolyear`  (
  `schoolyearID` int(11) NOT NULL AUTO_INCREMENT,
  `schooltype` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `schoolyear` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `schoolyeartitle` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `startingdate` date NOT NULL,
  `endingdate` date NOT NULL,
  `semestercode` int(11) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_usertype` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`schoolyearID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for section
-- ----------------------------
DROP TABLE IF EXISTS `section`;
CREATE TABLE `section`  (
  `sectionID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `section` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `category` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `capacity` int(11) NOT NULL,
  `classesID` int(11) NOT NULL,
  `teacherID` int(11) NOT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`sectionID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for setting
-- ----------------------------
DROP TABLE IF EXISTS `setting`;
CREATE TABLE `setting`  (
  `fieldoption` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`fieldoption`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for slider
-- ----------------------------
DROP TABLE IF EXISTS `slider`;
CREATE TABLE `slider`  (
  `sliderID` int(11) NOT NULL AUTO_INCREMENT,
  `pagesID` int(11) NOT NULL,
  `slider` int(11) NOT NULL,
  PRIMARY KEY (`sliderID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for smssettings
-- ----------------------------
DROP TABLE IF EXISTS `smssettings`;
CREATE TABLE `smssettings`  (
  `smssettingsID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `types` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `field_names` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `field_values` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `smssettings_extra` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`smssettingsID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sociallink
-- ----------------------------
DROP TABLE IF EXISTS `sociallink`;
CREATE TABLE `sociallink`  (
  `sociallinkID` int(11) NOT NULL AUTO_INCREMENT,
  `usertypeID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `facebook` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `twitter` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `linkedin` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `googleplus` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`sociallinkID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `studentID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dob` date DEFAULT NULL,
  `sex` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `religion` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phone` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `address` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `classesID` int(11) NOT NULL,
  `sectionID` int(11) NOT NULL,
  `bloodgroup` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `country` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `registerNO` int(9) NOT NULL,
  `state` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `library` int(11) NOT NULL,
  `hostel` int(11) NOT NULL,
  `transport` int(11) NOT NULL,
  `photo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `parentID` int(11) DEFAULT NULL,
  `createschoolyearID` int(11) NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  `username` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`studentID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1000011 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for studentextend
-- ----------------------------
DROP TABLE IF EXISTS `studentextend`;
CREATE TABLE `studentextend`  (
  `studentextendID` int(11) NOT NULL AUTO_INCREMENT,
  `studentID` int(11) NOT NULL,
  `studentgroupID` int(11) NOT NULL,
  `optionalsubjectID` int(11) NOT NULL,
  `extracurricularactivities` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `remarks` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`studentextendID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for studentgroup
-- ----------------------------
DROP TABLE IF EXISTS `studentgroup`;
CREATE TABLE `studentgroup`  (
  `studentgroupID` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`studentgroupID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for studentrelation
-- ----------------------------
DROP TABLE IF EXISTS `studentrelation`;
CREATE TABLE `studentrelation`  (
  `studentrelationID` int(11) NOT NULL AUTO_INCREMENT,
  `srstudentID` int(11) DEFAULT NULL,
  `srname` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `srclassesID` int(11) DEFAULT NULL,
  `srclasses` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `srregisterNO` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `srsectionID` int(11) DEFAULT NULL,
  `srsection` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `srstudentgroupID` int(11) NOT NULL,
  `sroptionalsubjectID` int(11) NOT NULL,
  `srschoolyearID` int(11) DEFAULT NULL,
  `sremail` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`studentrelationID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for sub_attendance
-- ----------------------------
DROP TABLE IF EXISTS `sub_attendance`;
CREATE TABLE `sub_attendance`  (
  `attendanceID` int(200) UNSIGNED NOT NULL AUTO_INCREMENT,
  `schoolyearID` int(11) NOT NULL,
  `studentID` int(11) NOT NULL,
  `classesID` int(11) NOT NULL,
  `sectionID` int(11) NOT NULL,
  `subjectID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `monthyear` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `a1` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a2` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a3` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a4` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a5` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a6` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a7` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a8` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a9` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a10` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a11` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a12` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a13` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a14` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a15` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a16` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a17` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a18` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a19` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a20` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a21` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a22` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a23` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a24` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a25` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a26` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a27` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a28` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a29` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a30` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a31` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`attendanceID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject`  (
  `subjectID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `classesID` int(11) NOT NULL,
  `teacherID` int(11) NOT NULL,
  `type` int(100) NOT NULL,
  `passmark` int(11) NOT NULL,
  `finalmark` int(11) NOT NULL,
  `subject` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `subject_author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `subject_code` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `teacher_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`subjectID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for syllabus
-- ----------------------------
DROP TABLE IF EXISTS `syllabus`;
CREATE TABLE `syllabus`  (
  `syllabusID` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `date` date NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `originalfile` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `file` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `classesID` int(11) NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  PRIMARY KEY (`syllabusID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for systemadmin
-- ----------------------------
DROP TABLE IF EXISTS `systemadmin`;
CREATE TABLE `systemadmin`  (
  `systemadminID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dob` date NOT NULL,
  `sex` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `religion` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phone` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `address` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `jod` date NOT NULL,
  `photo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `username` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `active` int(11) NOT NULL,
  `systemadminextra1` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `systemadminextra2` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`systemadminID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tattendance
-- ----------------------------
DROP TABLE IF EXISTS `tattendance`;
CREATE TABLE `tattendance`  (
  `tattendanceID` int(200) UNSIGNED NOT NULL AUTO_INCREMENT,
  `schoolyearID` int(11) NOT NULL,
  `teacherID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `monthyear` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `a1` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a2` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a3` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a4` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a5` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a6` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a7` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a8` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a9` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a10` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a11` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a12` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a13` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a14` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a15` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a16` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a17` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a18` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a19` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a20` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a21` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a22` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a23` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a24` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a25` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a26` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a27` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a28` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a29` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a30` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a31` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`tattendanceID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `teacherID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `designation` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dob` date NOT NULL,
  `sex` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `religion` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phone` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `address` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `jod` date NOT NULL,
  `photo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `username` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`teacherID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for themes
-- ----------------------------
DROP TABLE IF EXISTS `themes`;
CREATE TABLE `themes`  (
  `themesID` int(11) NOT NULL AUTO_INCREMENT,
  `sortID` int(11) NOT NULL DEFAULT 1,
  `themename` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `backend` int(11) NOT NULL DEFAULT 1,
  `frontend` int(11) NOT NULL DEFAULT 1,
  `topcolor` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `leftcolor` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`themesID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tmember
-- ----------------------------
DROP TABLE IF EXISTS `tmember`;
CREATE TABLE `tmember`  (
  `tmemberID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `studentID` int(11) NOT NULL,
  `transportID` int(11) NOT NULL,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phone` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `tbalance` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `tjoindate` date NOT NULL,
  PRIMARY KEY (`tmemberID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for transport
-- ----------------------------
DROP TABLE IF EXISTS `transport`;
CREATE TABLE `transport`  (
  `transportID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `route` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `vehicle` int(11) NOT NULL,
  `fare` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  PRIMARY KEY (`transportID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for uattendance
-- ----------------------------
DROP TABLE IF EXISTS `uattendance`;
CREATE TABLE `uattendance`  (
  `uattendanceID` int(200) UNSIGNED NOT NULL AUTO_INCREMENT,
  `schoolyearID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `monthyear` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `a1` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a2` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a3` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a4` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a5` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a6` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a7` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a8` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a9` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a10` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a11` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a12` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a13` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a14` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a15` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a16` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a17` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a18` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a19` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a20` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a21` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a22` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a23` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a24` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a25` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a26` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a27` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a28` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a29` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a30` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a31` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`uattendanceID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dob` date NOT NULL,
  `sex` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `religion` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phone` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `address` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `jod` date NOT NULL,
  `photo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `username` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `usertypeID` int(11) NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `active` int(11) NOT NULL,
  PRIMARY KEY (`userID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for usertype
-- ----------------------------
DROP TABLE IF EXISTS `usertype`;
CREATE TABLE `usertype`  (
  `usertypeID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_date` datetime NOT NULL,
  `modify_date` datetime NOT NULL,
  `create_userID` int(11) NOT NULL,
  `create_username` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_usertype` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`usertypeID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for vendor
-- ----------------------------
DROP TABLE IF EXISTS `vendor`;
CREATE TABLE `vendor`  (
  `vendorID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `contact_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`vendorID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for visitorinfo
-- ----------------------------
DROP TABLE IF EXISTS `visitorinfo`;
CREATE TABLE `visitorinfo`  (
  `visitorID` bigint(12) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `email_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `phone` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `photo` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `company_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `coming_from` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `representing` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `to_meet_personID` int(11) NOT NULL,
  `to_meet_usertypeID` int(11) NOT NULL,
  `check_in` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `check_out` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` int(11) NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  PRIMARY KEY (`visitorID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for weaverandfine
-- ----------------------------
DROP TABLE IF EXISTS `weaverandfine`;
CREATE TABLE `weaverandfine`  (
  `weaverandfineID` int(11) NOT NULL AUTO_INCREMENT,
  `globalpaymentID` int(11) NOT NULL,
  `invoiceID` int(11) NOT NULL,
  `paymentID` int(11) NOT NULL,
  `studentID` int(11) NOT NULL,
  `schoolyearID` int(11) NOT NULL,
  `weaver` double NOT NULL,
  `fine` double NOT NULL,
  PRIMARY KEY (`weaverandfineID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for xxx_ini_config
-- ----------------------------
DROP TABLE IF EXISTS `xxx_ini_config`;
CREATE TABLE `xxx_ini_config`  (
  `configID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `config_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`configID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;

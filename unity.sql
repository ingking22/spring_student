-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema tkksm
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tkksm
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tkksm` DEFAULT CHARACTER SET utf8 ;
USE `tkksm` ;

-- -----------------------------------------------------
-- Table `tkksm`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`category` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`category` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `description` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 45
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `tkksm`.`university`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`university` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`university` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `tkksm`.`board`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`board` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`board` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `university_id` INT(10) UNSIGNED NOT NULL,
  `category_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `category_id` (`category_id` ASC, `university_id` ASC) VISIBLE,
  INDEX `fk_board_university1_idx` (`university_id` ASC) VISIBLE,
  INDEX `fk_board_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_board_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `tkksm`.`category` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_board_university1`
    FOREIGN KEY (`university_id`)
    REFERENCES `tkksm`.`university` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 64
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `tkksm`.`major`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`major` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`major` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tkksm`.`university_major`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`university_major` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`university_major` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `university_id` INT(10) UNSIGNED NOT NULL,
  `major_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `major_university_major_fk_1` (`major_id` ASC) VISIBLE,
  INDEX `uni_university_major_fk_1` (`university_id` ASC) VISIBLE,
  CONSTRAINT `major_university_major_fk_1`
    FOREIGN KEY (`major_id`)
    REFERENCES `tkksm`.`major` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `uni_university_major_fk_1`
    FOREIGN KEY (`university_id`)
    REFERENCES `tkksm`.`university` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tkksm`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`course` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`course` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `credit` INT(10) UNSIGNED NOT NULL,
  `university_major_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `uni_major_course_fk_1` (`university_major_id` ASC) VISIBLE,
  CONSTRAINT `uni_major_course_fk_1`
    FOREIGN KEY (`university_major_id`)
    REFERENCES `tkksm`.`university_major` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tkksm`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`member` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`member` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(50) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `password` VARCHAR(60) NULL DEFAULT NULL,
  `img` TEXT NULL DEFAULT NULL,
  `status` VARCHAR(15) NOT NULL,
  `email_auth` VARCHAR(15) NOT NULL,
  `university_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_member_university1_idx` (`university_id` ASC) VISIBLE,
  CONSTRAINT `fk_member_university1`
    FOREIGN KEY (`university_id`)
    REFERENCES `tkksm`.`university` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 160
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `tkksm`.`course_rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`course_rating` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`course_rating` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rating` FLOAT UNSIGNED NOT NULL,
  `comment` TEXT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `member_id` INT(10) UNSIGNED NOT NULL,
  `course_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lecture_rating_member1` (`member_id` ASC) VISIBLE,
  INDEX `course_rating_course_fk_1` (`course_id` ASC) VISIBLE,
  CONSTRAINT `course_rating_course_fk_1`
    FOREIGN KEY (`course_id`)
    REFERENCES `tkksm`.`course` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_lecture_rating_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `tkksm`.`member` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 86
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tkksm`.`emailauth`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`emailauth` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`emailauth` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `emailkey` VARCHAR(10) NOT NULL,
  `validity` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `emailkey` (`emailkey` ASC) VISIBLE,
  UNIQUE INDEX `validity` (`validity` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 445
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tkksm`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`post` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`post` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NOT NULL,
  `content` TEXT NOT NULL,
  `good` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `report` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `views` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `anonymous` VARCHAR(5) NOT NULL DEFAULT 'TRUE',
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `member_id` INT(10) UNSIGNED NOT NULL,
  `board_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_post_member1_idx` (`member_id` ASC) VISIBLE,
  INDEX `fk_post_board1_idx` (`board_id` ASC) VISIBLE,
  CONSTRAINT `fk_post_board1`
    FOREIGN KEY (`board_id`)
    REFERENCES `tkksm`.`board` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_post_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `tkksm`.`member` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 577
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `tkksm`.`post_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`post_detail` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`post_detail` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(10) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `post_id` INT(10) UNSIGNED NOT NULL,
  `member_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `post_id` (`post_id` ASC, `member_id` ASC) VISIBLE,
  INDEX `fk_post_detail_post1_idx` (`post_id` ASC) VISIBLE,
  INDEX `fk_post_detail_member1_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_post_detail_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `tkksm`.`member` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_post_detail_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `tkksm`.`post` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 240
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `tkksm`.`reply`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`reply` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`reply` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `good` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `report` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `parent` INT(10) UNSIGNED NULL DEFAULT NULL,
  `status` VARCHAR(20) NOT NULL DEFAULT 'NOT_DELETED',
  `anonymous` VARCHAR(45) NOT NULL DEFAULT 'TRUE',
  `readable` VARCHAR(10) NOT NULL DEFAULT 'NOT_READ',
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `post_id` INT(10) UNSIGNED NOT NULL,
  `member_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reply_post1_idx` (`post_id` ASC) VISIBLE,
  INDEX `fk_reply_member1_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_reply_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `tkksm`.`member` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reply_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `tkksm`.`post` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 826
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `tkksm`.`reply_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`reply_detail` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`reply_detail` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(10) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `reply_id` INT(10) UNSIGNED NOT NULL,
  `member_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `reply_id` (`reply_id` ASC, `member_id` ASC) VISIBLE,
  UNIQUE INDEX `reply_id_2` (`reply_id` ASC, `member_id` ASC) VISIBLE,
  INDEX `fk_reply_detail_reply1_idx` (`reply_id` ASC) VISIBLE,
  INDEX `fk_reply_detail_member1_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_reply_detail_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `tkksm`.`member` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reply_detail_reply1`
    FOREIGN KEY (`reply_id`)
    REFERENCES `tkksm`.`reply` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 197
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `tkksm`.`timetable`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`timetable` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`timetable` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `semester` VARCHAR(45) NOT NULL,
  `member_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_schedule_member1` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_schedule_member1`
    FOREIGN KEY (`member_id`)
    REFERENCES `tkksm`.`member` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 60
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tkksm`.`subject_table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`subject_table` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`subject_table` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `subjectname` VARCHAR(10) NOT NULL,
  `color` VARCHAR(64) NULL DEFAULT NULL,
  `timetable_id` INT(11) NULL DEFAULT NULL,
  `course_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `timetable_id` (`timetable_id` ASC) VISIBLE,
  INDEX `course_subject_table_fk_1` (`course_id` ASC) VISIBLE,
  CONSTRAINT `course_subject_table_fk_1`
    FOREIGN KEY (`course_id`)
    REFERENCES `tkksm`.`course` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `subject_table_ibfk_1`
    FOREIGN KEY (`timetable_id`)
    REFERENCES `tkksm`.`timetable` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 88
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tkksm`.`rowColumn_table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`rowColumn_table` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`rowColumn_table` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `rowColumn` VARCHAR(10) NOT NULL,
  `subject_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `subject_id` (`subject_id` ASC) VISIBLE,
  CONSTRAINT `rowColumn_table_ibfk_1`
    FOREIGN KEY (`subject_id`)
    REFERENCES `tkksm`.`subject_table` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 168
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tkksm`.`suspended_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`suspended_history` ;

CREATE TABLE IF NOT EXISTS `tkksm`.`suspended_history` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `end_on` DATE NOT NULL,
  `reason` VARCHAR(100) NOT NULL,
  `member_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_suspended_history_member_idx` (`member_id` ASC) VISIBLE,
  CONSTRAINT `fk_suspended_history_member`
    FOREIGN KEY (`member_id`)
    REFERENCES `tkksm`.`member` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 89
DEFAULT CHARACTER SET = utf8mb4;

USE `tkksm` ;

-- -----------------------------------------------------
-- Placeholder table for view `tkksm`.`MyPostNewReplyView`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tkksm`.`MyPostNewReplyView` (`id` INT, `content` INT, `good` INT, `report` INT, `parent` INT, `status` INT, `anonymous` INT, `readable` INT, `created_at` INT, `updated_at` INT, `post_id` INT, `member_id` INT);

-- -----------------------------------------------------
-- Placeholder table for view `tkksm`.`MyReplyNewReReplyView`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tkksm`.`MyReplyNewReReplyView` (`postId` INT, `idOfReply` INT, `reply` INT, `replyCreatedAt` INT, `replyMemberId` INT, `idOfReReply` INT, `reReply` INT, `reReplyCreatedAt` INT, `reReplyMemberId` INT);

-- -----------------------------------------------------
-- View `tkksm`.`MyPostNewReplyView`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`MyPostNewReplyView`;
DROP VIEW IF EXISTS `tkksm`.`MyPostNewReplyView` ;
USE `tkksm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`tkksm`@`175.192.159.200` SQL SECURITY DEFINER VIEW `tkksm`.`MyPostNewReplyView` AS select `tkksm`.`reply`.`id` AS `id`,`tkksm`.`reply`.`content` AS `content`,`tkksm`.`reply`.`good` AS `good`,`tkksm`.`reply`.`report` AS `report`,`tkksm`.`reply`.`parent` AS `parent`,`tkksm`.`reply`.`status` AS `status`,`tkksm`.`reply`.`anonymous` AS `anonymous`,`tkksm`.`reply`.`readable` AS `readable`,`tkksm`.`reply`.`created_at` AS `created_at`,`tkksm`.`reply`.`updated_at` AS `updated_at`,`tkksm`.`reply`.`post_id` AS `post_id`,`tkksm`.`reply`.`member_id` AS `member_id` from `tkksm`.`reply` where (isnull(`tkksm`.`reply`.`parent`) and (`tkksm`.`reply`.`readable` = 'NOT_READ'));

-- -----------------------------------------------------
-- View `tkksm`.`MyReplyNewReReplyView`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tkksm`.`MyReplyNewReReplyView`;
DROP VIEW IF EXISTS `tkksm`.`MyReplyNewReReplyView` ;
USE `tkksm`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`tkksm`@`175.192.159.200` SQL SECURITY DEFINER VIEW `tkksm`.`MyReplyNewReReplyView` AS select `r`.`post_id` AS `postId`,`r`.`id` AS `idOfReply`,`r`.`content` AS `reply`,`r`.`created_at` AS `replyCreatedAt`,`r`.`member_id` AS `replyMemberId`,`rr`.`id` AS `idOfReReply`,`rr`.`content` AS `reReply`,`rr`.`created_at` AS `reReplyCreatedAt`,`rr`.`member_id` AS `reReplyMemberId` from (`tkksm`.`reply` `r` join `tkksm`.`reply` `rr` on((`r`.`id` = `rr`.`parent`))) where ((`r`.`member_id` <> `rr`.`member_id`) and (`rr`.`readable` = 'NOT_READ'));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

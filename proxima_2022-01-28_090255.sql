/*!40101 SET NAMES utf8 */;
/*!40014 SET FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/ proxima /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE proxima;

DROP TABLE IF EXISTS backup_permissions;
CREATE TABLE `backup_permissions` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `permission_nodes` varchar(100) DEFAULT NULL,
  `vip` tinyint(1) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS backup_user;
CREATE TABLE `backup_user` (
  `id` int NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `nachname` varchar(50) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `profile_likes` int DEFAULT NULL,
  `profile_pic` blob,
  `watchtime` float NOT NULL,
  `points` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS backup_videos;
CREATE TABLE `backup_videos` (
  `vid_id` int NOT NULL,
  `file` blob NOT NULL,
  `title` varchar(100) NOT NULL,
  `likes` int DEFAULT '0',
  `dislikes` int DEFAULT '0',
  `premium` tinyint(1) DEFAULT '0',
  `uploaded_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'always Current Timestamp',
  `clicks` int DEFAULT '0' COMMENT 'accumulating per view',
  PRIMARY KEY (`vid_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS comments;
CREATE TABLE `comments` (
  `com_id` int NOT NULL AUTO_INCREMENT,
  `author` varchar(20) NOT NULL,
  `comment` varchar(300) NOT NULL,
  `video` varchar(255) NOT NULL,
  `profile_id` int NOT NULL,
  `vid_id` int NOT NULL,
  `commented_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'always current timestamp',
  PRIMARY KEY (`com_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS has_permission;
CREATE TABLE `has_permission` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `id` int NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS interaction;
CREATE TABLE `interaction` (
  `user_id` int NOT NULL,
  `vid_id` int NOT NULL,
  `id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS permissions;
CREATE TABLE `permissions` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `permission_nodes` varchar(100) DEFAULT NULL,
  `vip` tinyint(1) DEFAULT '0',
  `id` int DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS tickets;
CREATE TABLE `tickets` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(50) NOT NULL,
  `author` varchar(20) NOT NULL,
  `header` varchar(50) NOT NULL,
  `body` text NOT NULL,
  `assigned_to` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS user;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `nachname` varchar(50) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `profile_likes` int DEFAULT '0',
  `profile_pic` blob,
  `watchtime` float DEFAULT '0',
  `points` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS videos;
CREATE TABLE `videos` (
  `vid_id` int NOT NULL AUTO_INCREMENT,
  `file` blob NOT NULL,
  `title` varchar(100) NOT NULL,
  `likes` int DEFAULT '0',
  `dislikes` int DEFAULT '0',
  `premium` tinyint(1) DEFAULT '0',
  `uploaded_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'always Current Timestamp',
  `clicks` int DEFAULT '0' COMMENT 'accumulating per view',
  PRIMARY KEY (`vid_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS watchhistory;
CREATE TABLE `watchhistory` (
  `user_id` int NOT NULL,
  `vid_id` int NOT NULL,
  `id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;









INSERT INTO user(id,username,password,name,nachname,email,profile_likes,profile_pic,watchtime,points) VALUES(1,'JJ','wasd','JB','JBD','@gg',0,NULL,0,0),(2,'JJDB','wasd','JB','JBD','@gg',0,NULL,0,0);
DROP PROCEDURE IF EXISTS permission_backup;
CREATE PROCEDURE `permission_backup`()
BEGIN
INSERT INTO backup_permissions(user_id,permission_nodes,vip)
   SELECT * FROM permission;
END;

DROP PROCEDURE IF EXISTS user_backup;
CREATE PROCEDURE `user_backup`()
BEGIN
   INSERT INTO backup_user(id,username,password,name,nachname,email,profile_likes,profile_pic,profile_id)
   SELECT * FROM user ;
END;

DROP PROCEDURE IF EXISTS videos_backup;
CREATE PROCEDURE `videos_backup`()
BEGIN
    INSERT INTO backup_videos(vid_id,file,title,likes,dislikes,premium,uploaded_on,clicks)
    SELECT * FROM videos;
END;
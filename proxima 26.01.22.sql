-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 26. Jan 2022 um 07:36
-- Server-Version: 10.4.22-MariaDB
-- PHP-Version: 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `proxima`
--

DELIMITER $$
--
-- Prozeduren
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `permission_backup` ()  BEGIN
INSERT INTO backup_permissions(user_id,permission_nodes,vip)
   SELECT * FROM permission;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_backup` ()  BEGIN
   INSERT INTO backup_user(id,username,password,name,nachname,email,profile_likes,profile_pic,profile_id)
   SELECT * FROM user ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `videos_backup` ()  BEGIN
    INSERT INTO backup_videos(vid_id,file,title,likes,dislikes,premium,uploaded_on,clicks)
    SELECT * FROM videos;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `backup_permissions`
--

CREATE TABLE `backup_permissions` (
  `user_id` int(11) NOT NULL,
  `permission_nodes` varchar(100) DEFAULT NULL,
  `vip` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `backup_user`
--

CREATE TABLE `backup_user` (
  `id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `nachname` varchar(50) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `profile_likes` int(11) DEFAULT NULL,
  `profile_pic` blob DEFAULT NULL,
  `watchtime` float NOT NULL,
  `points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `backup_videos`
--

CREATE TABLE `backup_videos` (
  `vid_id` int(11) NOT NULL,
  `file` blob NOT NULL,
  `title` varchar(100) NOT NULL,
  `likes` int(11) DEFAULT 0,
  `dislikes` int(11) DEFAULT 0,
  `premium` tinyint(1) DEFAULT 0,
  `uploaded_on` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'always Current Timestamp',
  `clicks` int(11) DEFAULT 0 COMMENT 'accumulating per view'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `comments`
--

CREATE TABLE `comments` (
  `com_id` int(11) NOT NULL,
  `author` varchar(20) NOT NULL,
  `comment` varchar(300) NOT NULL,
  `video` varchar(255) NOT NULL,
  `profile_id` int(11) NOT NULL,
  `vid_id` int(11) NOT NULL,
  `commented_on` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'always current timestamp'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `has_permission`
--

CREATE TABLE `has_permission` (
  `user_id` int(11) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `interaction`
--

CREATE TABLE `interaction` (
  `user_id` int(11) NOT NULL,
  `vid_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `permissions`
--

CREATE TABLE `permissions` (
  `user_id` int(11) NOT NULL,
  `permission_nodes` varchar(100) DEFAULT NULL,
  `vip` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Trigger `permissions`
--
DELIMITER $$
CREATE TRIGGER `permission_backup_tr` BEFORE UPDATE ON `permissions` FOR EACH ROW BEGIN
    CALL permission_backup();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tickets`
--

CREATE TABLE `tickets` (
  `ticket_id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `author` varchar(20) NOT NULL,
  `header` varchar(50) NOT NULL,
  `body` text NOT NULL,
  `assigned_to` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `nachname` varchar(50) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `profile_likes` int(11) DEFAULT 0,
  `profile_pic` blob DEFAULT NULL,
  `watchtime` float DEFAULT 0,
  `points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `name`, `nachname`, `email`, `profile_likes`, `profile_pic`, `watchtime`, `points`) VALUES
(1, 'JJ', 'wasd', 'JB', 'JBD', '@gg', 0, NULL, 0, 0),
(2, 'JJDB', 'wasd', 'JB', 'JBD', '@gg', 0, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `videos`
--

CREATE TABLE `videos` (
  `vid_id` int(11) NOT NULL,
  `file` blob NOT NULL,
  `title` varchar(100) NOT NULL,
  `likes` int(11) DEFAULT 0,
  `dislikes` int(11) DEFAULT 0,
  `premium` tinyint(1) DEFAULT 0,
  `uploaded_on` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'always Current Timestamp',
  `clicks` int(11) DEFAULT 0 COMMENT 'accumulating per view'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Trigger `videos`
--
DELIMITER $$
CREATE TRIGGER `videos_backup_tr` BEFORE UPDATE ON `videos` FOR EACH ROW BEGIN
    CALL videos_backup();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `watchhistory`
--

CREATE TABLE `watchhistory` (
  `user_id` int(11) NOT NULL,
  `vid_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `backup_permissions`
--
ALTER TABLE `backup_permissions`
  ADD PRIMARY KEY (`user_id`);

--
-- Indizes für die Tabelle `backup_user`
--
ALTER TABLE `backup_user`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `backup_videos`
--
ALTER TABLE `backup_videos`
  ADD PRIMARY KEY (`vid_id`);

--
-- Indizes für die Tabelle `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`com_id`);

--
-- Indizes für die Tabelle `has_permission`
--
ALTER TABLE `has_permission`
  ADD PRIMARY KEY (`user_id`);

--
-- Indizes für die Tabelle `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`user_id`);

--
-- Indizes für die Tabelle `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ticket_id`);

--
-- Indizes für die Tabelle `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `videos`
--
ALTER TABLE `videos`
  ADD PRIMARY KEY (`vid_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `backup_permissions`
--
ALTER TABLE `backup_permissions`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `comments`
--
ALTER TABLE `comments`
  MODIFY `com_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `has_permission`
--
ALTER TABLE `has_permission`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `permissions`
--
ALTER TABLE `permissions`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `videos`
--
ALTER TABLE `videos`
  MODIFY `vid_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

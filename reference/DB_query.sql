-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 17, 2020 at 09:41 PM
-- Server version: 5.7.28-0ubuntu0.18.04.4
-- PHP Version: 7.2.24-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `facerecognition`
--

-- --------------------------------------------------------

--
-- Table structure for table `Student`
--
DROP TABLE IF EXISTS `Student`;
DROP TABLE IF EXISTS `HasCourse`;
DROP TABLE IF EXISTS `Course`;
DROP TABLE IF EXISTS `Record`;
DROP TABLE IF EXISTS `TimeSlot`;

# Create TABLE 'Student'
CREATE TABLE Student (
  `student_id` int AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(70) NOT NULL,
  PRIMARY KEY(`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Insert sample data into Student
INSERT INTO `Student` (`username`, `email`) 
    VALUES ('Sky', 'skywcs@connect.hku.hk'), 
    ('Lemuel', 'lemuellee.kl@gmail.com'), 
    ('Riley', 'skywcs@connect.hku.hk');

# Create TABLE 'TimeSlot'
CREATE TABLE `TimeSlot` (
  `timeSlot_id` int NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`timeSlot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#Insert sample data into TimeSlot
INSERT INTO `TimeSlot`
    VALUES (1, '9:30', '10:25'), 
    (2, '10:30', '11:25'),
    (3, '11:30', '12:25'),
    (4, '12:30', '13:25'),
    (5, '13:30', '14:25'),
    (6, '14:30', '15:25'),
    (7, '15:30', '16:25'),
    (8, '16:30', '17:25'),
    (9, '17:30', '18:25'),
    (10, '18:30', '19:25');

# Create TABLE 'Course'
CREATE TABLE `Course` (
  `course_id` int NOT NULL,
  `timeSlot_id` int NOT NULL,
  `day` int NOT NULL, # Range [1,5] 1: Mon, 2: Tuesday...
  `classroom` varchar(60) NOT NULL,
  `message` varchar(200),
  `zoomLink` varchar(200),
  `notes` varchar(100),
  `other` varchar(200),
  PRIMARY KEY (`course_id`),
  FOREIGN KEY (`timeSlot_id`) REFERENCES TimeSlot(`TimeSlot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO Course 
    VALUES (1, 1, 1, 'Meng Wah Complex MWT2', 'Welcome to DBMS', 'https://hku.zoom.us/rec/play/JR7T4-Hk_AfD1sk1rm6qPzrnukGBMcj5wEDoiiEcje9g78dU8vDNtkAMIJYORJtOn5An54ls6lsX6Pdp.qjBu_xlFu3g_MZw4?continueMode=true', 'None', 'None'),
    (2, 3, 1, 'Central Prodium, Centennial CPD-LG.01', 'Welcome students', 'https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true', 'None', 'None'),
    (3, 4, 1, 'Chong Yuet Ming Physics CYPP2', 'Welcome students', 'https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true', 'None', 'None'),
    (4, 8, 1, 'Library Extension Building LE4', 'Welcome students', 'https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true', 'None', 'None'),
    (5, 1, 2, 'Central Prodium, Centennial CPD-LG.01', 'Welcome students', 'https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true', 'None', 'None'),
    (6, 4, 3, 'Chong Yuet Ming Physics CYPP2', 'Welcome students', 'https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true', 'None', 'None'),
    (7, 6, 3, 'Meng Wah Complex MWT2', 'Welcome students', 'https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true', 'None', 'None'),
    (8, 3, 4, 'Central Prodium, Centennial CPD-LG.01', 'Welcome students', 'https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true', 'None', 'None'),
    (9, 4, 4, 'Library Extension Building LE4', 'Welcome students', 'https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true', 'None', 'None'),
    (10, 9, 5, 'Chong Yuet Ming Physics CYPP2', 'Welcome students', 'https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true', 'None', 'None');


# Create TABLE 'Record'
CREATE TABLE `Record` (
  `student_id` int NOT NULL,
  `login_time` datetime NOT NULL,
  `logout_time` datetime NOT NULL,
  `duration` int NOT NULL,
  FOREIGN KEY (`student_id`) REFERENCES Student(`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Insert data into Record
INSERT INTO `Record` 
    VALUES (1, '2022-11-14 10:14:07', '2022-11-14 10:15:57', 700),
     (1, '2022-11-14 11:44:43', '2022-11-14 12:12:11', 500),
     (1, '2022-11-15 18:14:07', '2022-11-15 18:19:07', 300),
     (2, '2022-11-15 18:20:57', '2022-11-14 18:30:58', 60),
     (3, '2022-11-16 09:32:15', '2022-11-16 10:48:19', 60);


# Create TABLE 'HasCourse'
CREATE TABLE `HasCourse` (
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  PRIMARY KEY (`student_id`, `course_id`),
  FOREIGN KEY (`student_id`) REFERENCES Student(`student_id`) ON DELETE CASCADE,
  FOREIGN KEY (`course_id`) REFERENCES Course(`course_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

#Insert sample data into HasCourse
INSERT INTO `HasCourse`
    VALUES (1,1),
    (1,2),
    (1,3),
    (2,2),
    (2,3),
    (3,1),
    (3,2),
    (3,3);


#LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
#INSERT INTO `Student` VALUES (1, "JACK", NOW(), '2021-01-20');
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
#UNLOCK TABLES;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

CREATE DATABASE  IF NOT EXISTS `facerecognition` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `facerecognition`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: facerecognition
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_id` int NOT NULL,
  `course_title` varchar(30) NOT NULL,
  `timeSlot_id` int NOT NULL,
  `day` int NOT NULL,
  `classroom` varchar(60) NOT NULL,
  `message` varchar(200) DEFAULT NULL,
  `zoomLink` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `timeSlot_id` (`timeSlot_id`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`timeSlot_id`) REFERENCES `timeslot` (`timeSlot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'Intro to DBMS1',1,1,'Meng Wah Complex MWT2','Welcome to DBMS','https://hku.zoom.us/rec/play/JR7T4-Hk_AfD1sk1rm6qPzrnukGBMcj5wEDoiiEcje9g78dU8vDNtkAMIJYORJtOn5An54ls6lsX6Pdp.qjBu_xlFu3g_MZw4?continueMode=true'),(2,'Intro to DBMS2',3,0,'Central Prodium, Centennial CPD-LG.01','Welcome students','https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true'),(3,'Intro to DBMS3',4,0,'Chong Yuet Ming Physics CYPP2','Welcome students','https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true'),(4,'Intro to DBMS4',8,0,'Library Extension Building LE4','Welcome students','https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true'),(5,'Intro to DBMS5',1,1,'Central Prodium, Centennial CPD-LG.01','Welcome students','https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true'),(6,'Intro to DBMS6',4,2,'Chong Yuet Ming Physics CYPP2','Welcome students','https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true'),(7,'Intro to DBMS7',6,3,'Meng Wah Complex MWT2','Welcome students','https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true'),(8,'Intro to DBMS8',3,3,'Central Prodium, Centennial CPD-LG.01','Welcome students','https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true'),(9,'Intro to DBMS9',4,3,'Library Extension Building LE4','Welcome students','https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true'),(10,'Intro to DBMS10',13,3,'Chong Yuet Ming Physics CYPP2','Welcome students','https://hku.zoom.us/rec/play/44RSxgjo8sEQbDbCnj5MGU12iphMNNEdfsQ0muIhDlg5K2EaXOUOcVYwfBcOHSHnPmdg8WIpr8cz_rrt._lU525ClQSSUWqMo?continueMode=true');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hascourse`
--

DROP TABLE IF EXISTS `hascourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hascourse` (
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  PRIMARY KEY (`student_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `hascourse_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE,
  CONSTRAINT `hascourse_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hascourse`
--

LOCK TABLES `hascourse` WRITE;
/*!40000 ALTER TABLE `hascourse` DISABLE KEYS */;
INSERT INTO `hascourse` VALUES (1,1),(3,1),(1,2),(2,2),(3,2),(1,3),(2,3),(3,3),(1,10),(2,10);
/*!40000 ALTER TABLE `hascourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `record`
--

DROP TABLE IF EXISTS `record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `record` (
  `student_id` int NOT NULL,
  `login_time` datetime NOT NULL,
  `logout_time` datetime NOT NULL,
  `duration` int NOT NULL,
  KEY `student_id` (`student_id`),
  CONSTRAINT `record_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `record`
--

LOCK TABLES `record` WRITE;
/*!40000 ALTER TABLE `record` DISABLE KEYS */;
INSERT INTO `record` VALUES (1,'2022-11-14 10:14:07','2022-11-14 10:15:57',700),(1,'2022-11-14 11:44:43','2022-11-14 12:12:11',500),(1,'2022-11-15 18:14:07','2022-11-15 18:19:07',300),(2,'2022-11-15 18:20:57','2022-11-14 18:30:58',60),(3,'2022-11-16 09:32:15','2022-11-16 10:48:19',60),(2,'2022-11-16 02:36:28','2022-11-16 02:38:40',131),(2,'2022-11-16 02:48:31','2022-11-16 02:49:12',40),(2,'2022-11-16 02:49:14','2022-11-16 02:49:47',33),(2,'2022-11-16 03:01:40','2022-11-16 03:02:44',63),(2,'2022-11-16 03:07:34','2022-11-16 03:07:52',17),(2,'2022-11-16 03:25:48','2022-11-16 03:32:26',398),(2,'2022-11-16 03:32:38','2022-11-16 03:47:02',863),(2,'2022-11-16 03:49:33','2022-11-16 03:49:42',8),(2,'2022-11-16 03:51:08','2022-11-16 03:51:30',22),(2,'2022-11-16 03:51:38','2022-11-16 03:51:42',3),(2,'2022-11-16 03:51:43','2022-11-16 03:53:29',105),(2,'2022-11-16 03:53:31','2022-11-16 03:56:28',176),(2,'2022-11-16 04:05:17','2022-11-16 04:05:33',15),(2,'2022-11-16 04:05:36','2022-11-16 04:13:27',470),(2,'2022-11-16 04:13:30','2022-11-16 04:27:38',848),(2,'2022-11-16 04:39:39','2022-11-16 04:43:17',217),(2,'2022-11-16 04:52:04','2022-11-16 04:52:17',12),(2,'2022-11-16 04:56:21','2022-11-16 04:57:21',60),(2,'2022-11-16 04:58:40','2022-11-16 04:58:42',1),(2,'2022-11-16 05:00:05','2022-11-16 05:00:08',2),(2,'2022-11-16 05:00:19','2022-11-16 05:01:03',43),(2,'2022-11-16 05:12:02','2022-11-16 05:23:31',688),(2,'2022-11-16 05:52:38','2022-11-16 05:52:47',8),(2,'2022-11-16 06:08:29','2022-11-16 06:12:29',240),(2,'2022-11-16 06:12:30','2022-11-16 06:12:32',1),(2,'2022-11-16 06:12:50','2022-11-16 06:12:52',1),(2,'2022-11-16 06:12:53','2022-11-16 06:14:26',93),(2,'2022-11-16 06:14:29','2022-11-16 06:15:45',76),(1,'2022-11-17 01:37:08','2022-11-17 01:37:41',33),(2,'2022-11-17 01:37:51','2022-11-17 01:37:54',3),(1,'2022-11-17 01:37:56','2022-11-17 01:50:08',731),(1,'2022-11-17 01:50:12','2022-11-17 01:52:11',119),(1,'2022-11-17 01:52:17','2022-11-17 02:05:25',787),(1,'2022-11-17 02:26:27','2022-11-17 02:38:03',696),(2,'2022-11-17 03:42:42','2022-11-17 03:46:29',226),(2,'2022-11-17 03:59:16','2022-11-17 04:02:04',168),(2,'2022-11-17 04:24:29','2022-11-17 04:25:40',71);
/*!40000 ALTER TABLE `record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resource`
--

DROP TABLE IF EXISTS `resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resource` (
  `resource_id` int NOT NULL,
  `course_id` int NOT NULL,
  `url` varchar(200) NOT NULL,
  `name` varchar(45) NOT NULL DEFAULT '<not set>',
  KEY `resource_ibfk_1_idx` (`course_id`),
  CONSTRAINT `resource_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource`
--

LOCK TABLES `resource` WRITE;
/*!40000 ALTER TABLE `resource` DISABLE KEYS */;
INSERT INTO `resource` VALUES (0,10,'https://www.example.com','Tutorial 1 Exercise'),(0,10,'https://www.example.com','Lecture 1 Notes');
/*!40000 ALTER TABLE `resource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(70) NOT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'Sky','skywcs@connect.hku.hk'),(2,'Lemuel','lemuellee.kl@gmail.com'),(3,'Riley','skywcs@connect.hku.hk');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeslot`
--

DROP TABLE IF EXISTS `timeslot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timeslot` (
  `timeSlot_id` int NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  PRIMARY KEY (`timeSlot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeslot`
--

LOCK TABLES `timeslot` WRITE;
/*!40000 ALTER TABLE `timeslot` DISABLE KEYS */;
INSERT INTO `timeslot` VALUES (1,'09:30:00','10:25:00'),(2,'10:30:00','11:25:00'),(3,'11:30:00','12:25:00'),(4,'12:30:00','13:25:00'),(5,'13:30:00','14:25:00'),(6,'14:30:00','15:25:00'),(7,'15:30:00','16:25:00'),(8,'16:30:00','17:25:00'),(9,'17:30:00','18:25:00'),(10,'18:30:00','19:25:00'),(11,'19:30:00','20:25:00'),(12,'20:30:00','21:25:00'),(13,'01:30:00','02:25:00');
/*!40000 ALTER TABLE `timeslot` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-17 13:27:26

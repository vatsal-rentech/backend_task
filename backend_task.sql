-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: backend_task
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assignment_assignment`
--

DROP TABLE IF EXISTS `assignment_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignment_assignment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assignment_name` varchar(50) NOT NULL,
  `assignment_description` longtext NOT NULL,
  `assignment_due_date` date NOT NULL,
  `assignment_score` int NOT NULL,
  `assignment_created` datetime(6) NOT NULL,
  `assign_from_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assignment_assignment_assign_from_id_73e3e05a_fk_auth_user_id` (`assign_from_id`),
  CONSTRAINT `assignment_assignment_assign_from_id_73e3e05a_fk_auth_user_id` FOREIGN KEY (`assign_from_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment_assignment`
--

LOCK TABLES `assignment_assignment` WRITE;
/*!40000 ALTER TABLE `assignment_assignment` DISABLE KEYS */;
INSERT INTO `assignment_assignment` VALUES (1,'assignment1','sample assignment1','2023-11-30',80,'2023-09-01 11:07:54.465918',4),(2,'assignment2','sample assignment2','2023-10-30',50,'2023-09-01 11:08:12.283678',4),(3,'assignment3','sample assignment3','2023-10-25',25,'2023-09-01 11:09:14.707548',5);
/*!40000 ALTER TABLE `assignment_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment_assignment_assign_to`
--

DROP TABLE IF EXISTS `assignment_assignment_assign_to`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignment_assignment_assign_to` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assignment_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `assignment_assignment_as_assignment_id_user_id_b282bc71_uniq` (`assignment_id`,`user_id`),
  KEY `assignment_assignment_assign_to_user_id_84675af3_fk_auth_user_id` (`user_id`),
  CONSTRAINT `assignment_assignmen_assignment_id_d49b0be5_fk_assignmen` FOREIGN KEY (`assignment_id`) REFERENCES `assignment_assignment` (`id`),
  CONSTRAINT `assignment_assignment_assign_to_user_id_84675af3_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment_assignment_assign_to`
--

LOCK TABLES `assignment_assignment_assign_to` WRITE;
/*!40000 ALTER TABLE `assignment_assignment_assign_to` DISABLE KEYS */;
INSERT INTO `assignment_assignment_assign_to` VALUES (1,1,2),(2,1,3),(3,2,2),(4,2,3),(5,3,2),(6,3,3),(7,3,6);
/*!40000 ALTER TABLE `assignment_assignment_assign_to` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment_submittedassignments`
--

DROP TABLE IF EXISTS `assignment_submittedassignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignment_submittedassignments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `assignment_id_id` bigint NOT NULL,
  `assign_student_answer` longtext NOT NULL,
  `assignment_is_submitted` tinyint(1) NOT NULL,
  `assignment_submitted_at` datetime(6) NOT NULL,
  `assignment_submitted_by_id` int NOT NULL,
  `assignment_obtain_score` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assignment_submitted_assignment_submitted_5cf16348_fk_auth_user` (`assignment_submitted_by_id`),
  KEY `assignment_submittedassignments_assignment_id_id_9d967448` (`assignment_id_id`),
  CONSTRAINT `assignment_submitted_assignment_id_id_9d967448_fk_assignmen` FOREIGN KEY (`assignment_id_id`) REFERENCES `assignment_assignment` (`id`),
  CONSTRAINT `assignment_submitted_assignment_submitted_5cf16348_fk_auth_user` FOREIGN KEY (`assignment_submitted_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment_submittedassignments`
--

LOCK TABLES `assignment_submittedassignments` WRITE;
/*!40000 ALTER TABLE `assignment_submittedassignments` DISABLE KEYS */;
INSERT INTO `assignment_submittedassignments` VALUES (1,1,'This is the sample answer.',1,'2023-09-01 11:10:12.889752',2,0),(2,2,'This is the sample answer.',1,'2023-09-01 11:10:33.571481',2,0),(3,2,'This is the sample answer2.',1,'2023-09-01 11:10:56.569485',3,40);
/*!40000 ALTER TABLE `assignment_submittedassignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (2,'student'),(1,'teacher');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add assignment',7,'add_assignment'),(26,'Can change assignment',7,'change_assignment'),(27,'Can delete assignment',7,'delete_assignment'),(28,'Can view assignment',7,'view_assignment'),(29,'Can add submitted assignments',8,'add_submittedassignments'),(30,'Can change submitted assignments',8,'change_submittedassignments'),(31,'Can delete submitted assignments',8,'delete_submittedassignments'),(32,'Can view submitted assignments',8,'view_submittedassignments');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$Yf4Evz4Us03WRkJjN8Gbie$3yXy4Dne1Fjsa/gfWEptw1c2Mjb7drxugGnhdTd+/m8=','2023-09-01 11:03:42.527375',1,'admin','','','',1,1,'2023-09-01 11:03:21.975972'),(2,'pbkdf2_sha256$600000$HsaVqWJ3oDyVHSlKJHHcsI$CLR36t0bontkjMSul6IFYvnOQLPXWSp3nKscY8ytrqU=',NULL,0,'student1','','','student1@gmail.com',0,1,'2023-09-01 11:05:02.843348'),(3,'pbkdf2_sha256$600000$8VhwJ7NfMiAJ1ai0JT9S2r$47Ljx0Yssh93CUdhBIybRIkRF0coOsppC52TDHcfpeU=',NULL,0,'student2','','','student2@gmail.com',0,1,'2023-09-01 11:06:49.481852'),(4,'pbkdf2_sha256$600000$OOBzl9FRheaVfPMXoNejWI$Vl0/jLOj0/tIixSFP6Sw5MLRd7nCWcfMRtFDFRjZTYw=',NULL,0,'teacher1','','','teacher1@gmail.com',0,1,'2023-09-01 11:07:06.685924'),(5,'pbkdf2_sha256$600000$vGEraE4CBAW01goS9mNudo$cYMWLsEE4a/wdGnDw/Yd/DeV/l8sQqCvbcupm0mFJ80=',NULL,0,'teacher2','','','teacher2@gmail.com',0,1,'2023-09-01 11:07:16.326894'),(6,'pbkdf2_sha256$600000$6nKXFkyUYtqMK485PanyyU$Kb69hU4WaZc82OgTF2dRpl1aOfBO96HoDe43vsWxnc4=',NULL,0,'student3','','','student3@gmail.com',0,1,'2023-09-01 11:08:44.110418');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (1,2,2),(2,3,2),(3,4,1),(4,5,1),(5,6,2);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(7,'assignment','assignment'),(8,'assignment','submittedassignments'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-09-01 11:02:25.964874'),(2,'auth','0001_initial','2023-09-01 11:02:26.253686'),(3,'admin','0001_initial','2023-09-01 11:02:26.333640'),(4,'admin','0002_logentry_remove_auto_add','2023-09-01 11:02:26.342635'),(5,'admin','0003_logentry_add_action_flag_choices','2023-09-01 11:02:26.350630'),(6,'assignment','0001_initial','2023-09-01 11:02:26.532527'),(7,'assignment','0002_assignment_assign_is_submitted_and_more','2023-09-01 11:02:26.615479'),(8,'assignment','0003_rename_assign_student_asnwer_assignment_assign_student_answer','2023-09-01 11:02:26.639464'),(9,'assignment','0004_remove_assignment_assign_is_submitted_and_more','2023-09-01 11:02:27.096203'),(10,'assignment','0005_alter_submittedassignments_assignment_id','2023-09-01 11:02:27.206137'),(11,'assignment','0006_rename_assign_is_submitted_submittedassignments_assignment_is_submitted','2023-09-01 11:02:27.227127'),(12,'assignment','0007_rename_assignment_submitted_date_submittedassignments_assignment_submitted_at','2023-09-01 11:02:27.249114'),(13,'assignment','0008_submittedassignments_assignment_obtain_score','2023-09-01 11:02:27.280096'),(14,'contenttypes','0002_remove_content_type_name','2023-09-01 11:02:27.396028'),(15,'auth','0002_alter_permission_name_max_length','2023-09-01 11:02:27.439004'),(16,'auth','0003_alter_user_email_max_length','2023-09-01 11:02:27.477982'),(17,'auth','0004_alter_user_username_opts','2023-09-01 11:02:27.488976'),(18,'auth','0005_alter_user_last_login_null','2023-09-01 11:02:27.572927'),(19,'auth','0006_require_contenttypes_0002','2023-09-01 11:02:27.576927'),(20,'auth','0007_alter_validators_add_error_messages','2023-09-01 11:02:27.585921'),(21,'auth','0008_alter_user_username_max_length','2023-09-01 11:02:27.635890'),(22,'auth','0009_alter_user_last_name_max_length','2023-09-01 11:02:27.685862'),(23,'auth','0010_alter_group_name_max_length','2023-09-01 11:02:27.705850'),(24,'auth','0011_update_proxy_permissions','2023-09-01 11:02:27.717844'),(25,'auth','0012_alter_user_first_name_max_length','2023-09-01 11:02:27.819785'),(26,'authentication','0001_initial','2023-09-01 11:02:28.087631'),(27,'authentication','0002_delete_customuser','2023-09-01 11:02:28.112619'),(28,'sessions','0001_initial','2023-09-01 11:02:28.138602'),(29,'assignment','0009_alter_submittedassignments_assignment_obtain_score','2023-09-01 11:16:46.151954');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('r6syxikwim11t6npshm2qwskiel6sy3q','.eJxVjDsOgzAQRO_iOrLYxR9ImZ4zWGuvHZNEtoShinL3gESRlDPvzbyFo23NbmtxcTOLqwBx-e08hWcsB-AHlXuVoZZ1mb08FHnSJqfK8XU73b-DTC3va4q9HRmj8qwBrQYFmIK1fdqzGXBEo8B6Quy6gSD0EJJOHC2D8oqN-HwBy0A3Yw:1qc1wE:VOKtrBpZLKj4JbTmHKLf_Rn8hpxhN4BEDjw4Nr37tB8','2023-09-15 11:03:42.531372');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-01 16:51:29

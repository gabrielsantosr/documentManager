-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: literature_manager
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(30) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (1,'Ringo','Starr'),(2,'Jack','Santa Maria'),(3,'Oliver','Sacks'),(4,'Katie','Caldessi'),(5,'John','Lennon'),(6,'Giancarlo','Caldessi'),(7,'Joshua','Marinacci'),(8,'George','Harrison'),(9,'Chris','Adamson'),(10,'Paul','McCartney'),(11,'Gabriel','García Márquez'),(14,'Mario','Benedetti'),(15,'Hug','Penguin'),(16,'Bill','Bryson'),(17,'Paul','Atkinson'),(18,'Martyn','Hammersley'),(19,'Theodore','Bjerken'),(20,'Bea','Mello'),(21,'Rob','Mello'),(22,'Ellen','Casey'),(23,'Tim','Cacciatore'),(24,'Patrick','Johnson'),(25,'Rajal','Cohen'),(26,'Joan','Davies'),(27,'Clara','Gallego-Cerveró'),(28,'Julio','Martín-Ruiz'),(29,'Laura','Ruiz-Sanchis'),(30,'Concepción','Ros-Ros');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authorship`
--

DROP TABLE IF EXISTS `authorship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorship` (
  `hierarchy` int DEFAULT NULL,
  `author_id` int NOT NULL,
  `document_id` int NOT NULL,
  PRIMARY KEY (`author_id`,`document_id`),
  KEY `FKA6913E47DDE540C7` (`author_id`),
  KEY `FKA6913E47CB404F87` (`document_id`),
  CONSTRAINT `FKA6913E47CB404F87` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`),
  CONSTRAINT `FKA6913E47DDE540C7` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorship`
--

LOCK TABLES `authorship` WRITE;
/*!40000 ALTER TABLE `authorship` DISABLE KEYS */;
INSERT INTO `authorship` VALUES (4,1,6),(1,2,2),(1,3,4),(1,3,5),(1,4,1),(1,5,6),(2,6,1),(1,7,3),(3,8,6),(2,9,3),(2,10,6),(1,17,7),(2,18,7),(1,19,8),(2,20,8),(3,21,8),(1,22,10),(1,23,9),(2,24,9),(3,25,9),(1,27,11),(2,28,11),(3,29,11),(4,30,11);
/*!40000 ALTER TABLE `authorship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_type`
--

DROP TABLE IF EXISTS `doc_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doc_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_type`
--

LOCK TABLES `doc_type` WRITE;
/*!40000 ALTER TABLE `doc_type` DISABLE KEYS */;
INSERT INTO `doc_type` VALUES (1,'Book'),(2,'Audio'),(3,'Journal Article'),(4,'Dissertation');
/*!40000 ALTER TABLE `doc_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doc_type_id` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `journal_name` varchar(80) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `sub_title` varchar(255) DEFAULT NULL,
  `vol_number` varchar(8) DEFAULT NULL,
  `vol_release` varchar(8) DEFAULT NULL,
  `edition` int DEFAULT NULL,
  `publisher` varchar(45) DEFAULT NULL,
  `publisher_location` varchar(45) DEFAULT NULL,
  `start_page` int DEFAULT NULL,
  `end_page` int DEFAULT NULL,
  `doi` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `journal_name` (`journal_name`,`vol_number`,`vol_release`,`year`),
  UNIQUE KEY `title` (`title`,`vol_number`,`vol_release`,`year`),
  KEY `FK335CD11B9FCEBC5B` (`doc_type_id`),
  CONSTRAINT `FK335CD11B9FCEBC5B` FOREIGN KEY (`doc_type_id`) REFERENCES `doc_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
INSERT INTO `document` VALUES (1,1,NULL,NULL,'The long and the short of Pasta','A collection of treasured Italian dishes',NULL,NULL,NULL,'Hardie Grant Books','London',NULL,NULL,NULL,'C:\\Users\\gabri\\OneDrive\\Escritorio\\pasta.jpg'),(2,1,NULL,NULL,'Indian vegetarian coockery',NULL,NULL,NULL,3,'Rider','London',NULL,NULL,NULL,'C:\\Users\\gabri\\OneDrive\\Escritorio\\indian.jpg'),(3,1,NULL,NULL,'Swing Hacks','Tips & Tool for Building Killer GUIs',NULL,NULL,1,'O\'Reilly','Sebastopol, California',NULL,NULL,NULL,'C:\\Users\\gabri\\OneDrive\\Escritorio\\swing_hacks.png'),(4,1,NULL,NULL,'Musicophilia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'C:\\Users\\gabri\\OneDrive\\Escritorio\\musicophilia.jpg'),(5,1,NULL,NULL,'The Man Who Mistook his Wife For A Hat',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'C:\\Users\\gabri\\OneDrive\\Escritorio\\Soundbites.mp4'),(6,2,NULL,NULL,'Revolver',NULL,NULL,NULL,NULL,'EMI','London',NULL,NULL,NULL,'https://open.spotify.com/album/3PRoXYsngSwjEQWR5PsHWR?si=QZoGinDLREKGrsRoCtDqGQ'),(7,1,2007,NULL,'Ethnography:','Principles in practice',NULL,NULL,NULL,'Routledge','New York',NULL,NULL,NULL,NULL),(8,3,2012,'Theatre,Dance and Performance Training','Cultivating a lively use of tension:',' the synergy between acting and the AT','3','1',NULL,NULL,NULL,27,40,NULL,NULL),(9,3,2020,'Kinesiology Review','Potential Mechanics of the Alexander Technique:','towards a comprhensive neurophysiological model','9','3',NULL,NULL,NULL,199,213,NULL,NULL),(10,4,2020,NULL,'Exploring the perceived impact of extensive training in the Alexander technique on the day-to-day lives of professional musicians',NULL,NULL,NULL,NULL,'Royal College of Music','London',NULL,NULL,NULL,NULL),(11,3,2018,'Medical Problems of Performing Artists','Pain perception in clarinetists with Playing-related pain after implementing a Specific Exercise Program',NULL,NULL,NULL,NULL,NULL,NULL,238,242,'https://doi.org/10.21091/mppa.2018.4035','C:\\Users\\gabri\\OneDrive\\Escritorio\\Cervero.pdf');
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `note` (
  `id` int NOT NULL AUTO_INCREMENT,
  `note_text` longtext NOT NULL,
  `document_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK33AFF2CB404F87` (`document_id`),
  CONSTRAINT `FK33AFF2CB404F87` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
INSERT INTO `note` VALUES (1,'Qué bueno que está!!',6),(2,'Acerca del descubrimiento del funcionamiento cerebral a partir de sus fallas',5),(3,'Tiene buenas instrucciones para hacer la pasta casera',1),(4,'Tiene historias de casos estudiados por el mismo autor',5),(5,'Éste me dio idea para construir un analizador de ondas sonoras',3),(6,'Eleanor Rigby, For No One, y otros éxitos',6);
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-21 16:32:22

-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: k_repair
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Last_name` varchar(45) DEFAULT NULL,
  `Phone_number` varchar(15) DEFAULT NULL,
  `Organization` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `compatibility`
--

DROP TABLE IF EXISTS `compatibility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compatibility` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Code` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `materials`
--

DROP TABLE IF EXISTS `materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materials` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Material` varchar(100) DEFAULT NULL,
  `Price` int DEFAULT NULL,
  `Materials_type_id` int DEFAULT NULL,
  `Quantity` int DEFAULT '0',
  `Location` int DEFAULT NULL,
  `Storage_id` int DEFAULT NULL,
  `Firm_id` int DEFAULT NULL,
  `Article` int DEFAULT NULL,
  `Compatibility_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Materials_type_id_idx` (`Materials_type_id`),
  KEY `Firm_id_idx` (`Firm_id`),
  KEY `Storage_id_idx` (`Storage_id`),
  KEY `Compatibility_id_idx` (`Compatibility_id`),
  CONSTRAINT `Compatibility_id` FOREIGN KEY (`Compatibility_id`) REFERENCES `compatibility` (`id`),
  CONSTRAINT `Firm_id` FOREIGN KEY (`Firm_id`) REFERENCES `tool_firms` (`id`),
  CONSTRAINT `Materials_type_id` FOREIGN KEY (`Materials_type_id`) REFERENCES `materials_type` (`id`),
  CONSTRAINT `Storage_id` FOREIGN KEY (`Storage_id`) REFERENCES `storages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `materials_type`
--

DROP TABLE IF EXISTS `materials_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materials_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_materials`
--

DROP TABLE IF EXISTS `order_materials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_materials` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Tool_id` int DEFAULT NULL,
  `Material_id` int DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Material_id_idx` (`Material_id`),
  KEY `order_materials_Tool_id_idx` (`Tool_id`),
  CONSTRAINT `Material_id` FOREIGN KEY (`Material_id`) REFERENCES `materials` (`id`),
  CONSTRAINT `order_materials_Tool_id` FOREIGN KEY (`Tool_id`) REFERENCES `tools` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_services`
--

DROP TABLE IF EXISTS `order_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Tool_id` int DEFAULT NULL,
  `Service_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Service_id_idx` (`Service_id`),
  KEY `order_services_Tool_id_idx` (`Tool_id`),
  CONSTRAINT `order_services_Tool_id` FOREIGN KEY (`Tool_id`) REFERENCES `tools` (`id`),
  CONSTRAINT `Service_id` FOREIGN KEY (`Service_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Client_id` int DEFAULT NULL,
  `Status_id` int DEFAULT NULL,
  `Note` varchar(300) DEFAULT NULL,
  `Date_creation` datetime DEFAULT NULL,
  `Date_completion` datetime DEFAULT NULL,
  `User` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Client_id_idx` (`Client_id`),
  KEY `Status_id_idx` (`Status_id`),
  KEY `User_idx` (`User`),
  CONSTRAINT `Client_id` FOREIGN KEY (`Client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `Status_id` FOREIGN KEY (`Status_id`) REFERENCES `statuses` (`id`),
  CONSTRAINT `User` FOREIGN KEY (`User`) REFERENCES `users` (`Login`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Role` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Service` varchar(40) DEFAULT NULL,
  `Price` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `statuses`
--

DROP TABLE IF EXISTS `statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statuses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storages`
--

DROP TABLE IF EXISTS `storages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Storage` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tool_firms`
--

DROP TABLE IF EXISTS `tool_firms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tool_firms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Firm` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tool_types`
--

DROP TABLE IF EXISTS `tool_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tool_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tools`
--

DROP TABLE IF EXISTS `tools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tools` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Order_id` int DEFAULT NULL,
  `Tool_type_id` int DEFAULT NULL,
  `Tool_firm_id` int DEFAULT NULL,
  `Model` varchar(100) DEFAULT NULL,
  `Defect` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tools_Order_id_idx` (`Order_id`),
  KEY `tool_type_id_idx` (`Tool_type_id`),
  KEY `Tool_firm_id_idx` (`Tool_firm_id`),
  CONSTRAINT `Tool_firm_id` FOREIGN KEY (`Tool_firm_id`) REFERENCES `tool_firms` (`id`),
  CONSTRAINT `tool_type_id` FOREIGN KEY (`Tool_type_id`) REFERENCES `tool_types` (`id`),
  CONSTRAINT `tools_Order_id` FOREIGN KEY (`Order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `Login` varchar(45) NOT NULL,
  `Password` varchar(45) DEFAULT NULL,
  `Role_id` int DEFAULT NULL,
  PRIMARY KEY (`Login`),
  KEY `role_idx` (`Role_id`),
  CONSTRAINT `role` FOREIGN KEY (`Role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-02 14:31:19

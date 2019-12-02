-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: localhost    Database: coffee_shop_db
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` bit(1) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_q0uja26qgu1atulenwup9rxyr` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (34,'Đường A, phường B, Quận Cam','nguyenvanb@gmail.com','MALE','Nguyễn Văn A','0123456777','$2a$10$fKZrFI4Dai1.6BXHXbRO0OWff8pF3haN3V0pnTfxZGIkB0OY8ZH66',_binary '','nguyenvana'),(4,'abc def ghi','ninhthuan199953@gmail.com','MALE','ninhthuan199953','0654213987','$2a$10$3nJfuOA273vNW1dI7UVukea3GOuF1ruuUgG258da3qyAk0OTnPZmi',_binary '','ninhthuan199953'),(32,'NTNT DN','ntnt1321999@gmail.com','MALE','NTNT NTNT','0123456888','$2a$10$J2DjeAYCI.zpqD7avxflUeHCfQOnqdGu6.Rxo2PvpPq0MCWJ8pZym',_binary '','ntnt1321999'),(33,'tester tester tester','testertester@gmail.com','MALE','Nguyễn Thị Tester','0333111222','$2a$10$GqLfpXNTN0TjBJrc8pBh8upG8arjb0UO.hqohe21V/y6CkbF41.Hq',_binary '','tester'),(2,'seller','seller@gmail.com','MALE','seller','0111155555','$2a$10$BKq.Az0xUTJKjTCz7EjZ2eElxuAB0NS.maz6GnM4CSLFx120yvzfK',_binary '','seller'),(29,'Làng Vũ Đại','ntn@gmail.com','FEMALE','Nguyễn Thị Nở','0555222333','$2a$10$3X4nsVRtPuRTa.RizzJf0O2bh5PLZqShiZ8DxGQGWjNK5FGUjxRqW',_binary '','thino'),(1,'admin','admin@gmail.com','MALE','ADMIN','0654321987','$2a$10$QZDb2hq/RuhqhpqepXmLcuxMjQheqGt6AtJAcjolPi01S8gNDI7oO',_binary '','admin'),(3,'manager address','manager@gmail.com','MALE','manager','0123456555','$2a$10$PwsBmEX8mkNz9pkMt9BNCuqIsl9/0NUlNd.zFSFu0F1O0rJRTYL7a',_binary '','manager'),(28,'64 Nguyễn Lương Bằng','ninhthuan1999@gmail.com','MALE','Thuận Ninh','0333444556','0123456',_binary '','ninhthuan1999');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_role`
--

DROP TABLE IF EXISTS `account_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `account_role` (
  `accountId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`accountId`,`roleId`),
  KEY `FK7w6ltqx0gj10wp83vg574sfy8` (`roleId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_role`
--

LOCK TABLES `account_role` WRITE;
/*!40000 ALTER TABLE `account_role` DISABLE KEYS */;
INSERT INTO `account_role` VALUES (1,1),(2,3),(3,3),(3,4),(4,2),(28,2),(29,2),(30,2),(31,2),(32,2),(33,2),(34,2);
/*!40000 ALTER TABLE `account_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (6,'trà kem sữa','1'),(5,'soda/mojito','1'),(4,'cà phê','1'),(7,'trà trái cây','1'),(9,'đá  xay','1'),(10,'nước ép','1'),(11,'trà sữa','1'),(12,'sữa chua','1'),(13,'ăn nhẹ','1');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `accountId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKenx5g28fsmom97xl7prw1pg7n` (`accountId`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (10,'abc def ghi','ninhthuan199953@gmail.com','MALE','Ninh Thuận 199953','0654213987',4),(11,'Làng Vũ Đại','chipheo@gmail.com','MALE','Chí phèo','0111222333',NULL),(12,'seller','seller@gmail.com','MALE','seller','0111155555',2),(13,'Đường A, phường B, Quận Cam','nguyenvana@gmail.com','MALE','Nguyễn Văn A','0123456777',34),(14,'Đường A, phường B, Quận Cam','nguyenvanb@gmail.com','MALE','Nguyễn Văn A','0123456777',34);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite`
--

DROP TABLE IF EXISTS `favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `favorite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` bit(1) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKsskuoi6u8b6tykfj5jy1wng9r` (`account_id`),
  KEY `FKbg4txsew6x3gl6r9swcq190hg` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
INSERT INTO `favorite` VALUES (14,_binary '',4,15),(15,_binary '',29,14),(16,_binary '\0',33,14),(17,_binary '',33,20),(18,_binary '\0',33,10),(19,_binary '\0',34,20),(20,_binary '\0',34,10);
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(255) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8sfun6tj1hqb85ed52o8mkqyh` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (1,'resources\\images\\landingPage\\products\\product.jpg',1),(2,'resources\\images\\landingPage\\products\\product.jpg',2),(3,'resources\\images\\landingPage\\products\\product.jpg',3),(14,'resources/images/landingPage/products/1572428282899_bac_xiu.jpg',6),(13,'resources/images/landingPage/products/1572428282890_bac_xiu.jpg',6),(15,'resources/images/landingPage/products/ca_phe_den.PNG',8),(16,'resources/images/landingPage/products/ca_phe_den.PNG',8),(17,'resources/images/landingPage/products/ca_phe_sua.PNG',9),(18,'resources/images/landingPage/products/ca_phe_sua.PNG',9),(19,'resources/images/landingPage/products/ca_phe_den_sai_gon.PNG',10),(20,'resources/images/landingPage/products/ca_phe_den_sai_gon.PNG',10),(21,'resources/images/landingPage/products/ca_phe_sua_sai_gon.PNG',11),(22,'resources/images/landingPage/products/ca_phe_sua_sai_gon.PNG',11),(23,'resources/images/landingPage/products/bac_xiu.PNG',12),(24,'resources/images/landingPage/products/bac_xiu.PNG',12),(25,'resources/images/landingPage/products/ca_phe_dua.PNG',13),(26,'resources/images/landingPage/products/ca_phe_dua.PNG',13),(27,'resources/images/landingPage/products/ca_cao.PNG',14),(28,'resources/images/landingPage/products/ca_cao.PNG',14),(29,'resources/images/landingPage/products/tra_hoa_nhai_kem_sua.PNG',15),(30,'resources/images/landingPage/products/tra_hoa_nhai_kem_sua.PNG',15),(31,'resources/images/landingPage/products/tra_olong_kem_sua.PNG',16),(32,'resources/images/landingPage/products/tra_olong_kem_sua.PNG',16),(33,'resources/images/landingPage/products/tra_dao_kem_sua.jpg',17),(34,'resources/images/landingPage/products/tra_dao_kem_sua.jpg',17),(35,'resources/images/landingPage/products/tra_xoai_kem_sua.PNG',18),(36,'resources/images/landingPage/products/tra_xoai_kem_sua.PNG',18),(37,'resources/images/landingPage/products/tra_hoa_dau_biet_kem_sua.PNG',19),(38,'resources/images/landingPage/products/tra_hoa_dau_biet_kem_sua.PNG',19),(39,'resources/images/landingPage/products/tra_earl_grey_kem_sua.PNG',20),(40,'resources/images/landingPage/products/tra_earl_grey_kem_sua.PNG',20),(41,'resources/images/landingPage/products/matcha_cheese_milk_foam.PNG',21),(42,'resources/images/landingPage/products/matcha_cheese_milk_foam.PNG',21),(43,'resources/images/landingPage/products/tra_dao.PNG',22),(44,'resources/images/landingPage/products/tra_dao.PNG',22),(45,'resources/images/landingPage/products/tra_dao_cam_sa.PNG',23),(46,'resources/images/landingPage/products/tra_dao_cam_sa.PNG',23),(47,'resources/images/landingPage/products/tra_oi_hong.PNG',24),(48,'resources/images/landingPage/products/tra_oi_hong.PNG',24),(49,'resources/images/landingPage/products/tra_kiwi.PNG',25),(50,'resources/images/landingPage/products/tra_kiwi.PNG',25),(51,'resources/images/landingPage/products/tra_gung.PNG',26),(52,'resources/images/landingPage/products/tra_gung.PNG',26),(53,'resources/images/landingPage/products/tra_lipton_hat_chia.PNG',27),(54,'resources/images/landingPage/products/tra_lipton_hat_chia.PNG',27),(55,'resources/images/landingPage/products/matcha_da_xay.PNG',28),(56,'resources/images/landingPage/products/matcha_da_xay.PNG',28),(57,'resources/images/landingPage/products/caramel_da_xay.PNG',29),(58,'resources/images/landingPage/products/caramel_da_xay.PNG',29),(59,'resources/images/landingPage/products/socola_da_xay.PNG',30),(60,'resources/images/landingPage/products/socola_da_xay.PNG',30),(61,'resources/images/landingPage/products/dau_tay_da_xay.PNG',31),(62,'resources/images/landingPage/products/dau_tay_da_xay.PNG',31),(63,'resources/images/landingPage/products/viet_quat.PNG',32),(64,'resources/images/landingPage/products/viet_quat.PNG',32),(65,'resources/images/landingPage/products/mojito_classic.PNG',33),(66,'resources/images/landingPage/products/mojito_classic.PNG',33),(67,'resources/images/landingPage/products/mojito_mint.PNG',34),(68,'resources/images/landingPage/products/mojito_mint.PNG',34),(69,'resources/images/landingPage/products/soda_tao_xanh.PNG',35),(70,'resources/images/landingPage/products/soda_tao_xanh.PNG',35),(71,'resources/images/landingPage/products/soda_viet_quat.PNG',36),(72,'resources/images/landingPage/products/soda_viet_quat.PNG',36),(73,'resources/images/landingPage/products/cóc ép.PNG',37),(74,'resources/images/landingPage/products/cóc ép.PNG',37),(75,'resources/images/landingPage/products/dua_ep.PNG',38),(76,'resources/images/landingPage/products/dua_ep.PNG',38),(77,'resources/images/landingPage/products/cam_ep.PNG',39),(78,'resources/images/landingPage/products/cam_ep.PNG',39),(79,'resources/images/landingPage/products/ổi ép.PNG',40),(80,'resources/images/landingPage/products/ổi ép.PNG',40),(81,'resources/images/landingPage/products/sua_tuoi_kem_trung.PNG',41),(82,'resources/images/landingPage/products/sua_tuoi_kem_trung.PNG',41),(83,'resources/images/landingPage/products/sua_tuoi_machito.PNG',42),(84,'resources/images/landingPage/products/sua_tuoi_machito.PNG',42),(85,'resources/images/landingPage/products/tra_sua_khoai_lang_tim.PNG',43),(86,'resources/images/landingPage/products/tra_sua_khoai_lang_tim.PNG',43),(87,'resources/images/landingPage/products/sua_tuoi_tran_chau_duong_den.PNG',44),(88,'resources/images/landingPage/products/sua_tuoi_tran_chau_duong_den.PNG',44),(89,'resources/images/landingPage/products/sua_chua_da.PNG',45),(90,'resources/images/landingPage/products/sua_chua_da.PNG',45),(91,'resources/images/landingPage/products/sua_chua_dau_tay.PNG',46),(92,'resources/images/landingPage/products/sua_chua_dau_tay.PNG',46),(96,'resources/images/landingPage/products/sua_chua_viet_quat.PNG',47),(95,'resources/images/landingPage/products/sua_chua_viet_quat.PNG',47),(97,'resources/images/landingPage/products/sua_chua_chanh_day.PNG',48),(98,'resources/images/landingPage/products/sua_chua_chanh_day.PNG',48),(99,'resources/images/landingPage/products/kho_ga_la_chanh.PNG',49),(100,'resources/images/landingPage/products/kho_ga_la_chanh.PNG',49),(101,'resources/images/landingPage/products/coc_oi_xi_muoi.PNG',50),(102,'resources/images/landingPage/products/coc_oi_xi_muoi.PNG',50),(103,'resources/images/landingPage/products/banh_tran_cuon.PNG',51),(104,'resources/images/landingPage/products/banh_tran_cuon.PNG',51);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetail`
--

DROP TABLE IF EXISTS `orderdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orderdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `size` varchar(2) DEFAULT NULL,
  `topping` varchar(255) DEFAULT NULL,
  `unitPrice` double NOT NULL,
  `orderId` int(11) DEFAULT NULL,
  `productId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKb51qdl923yoolek2tjtyati00` (`orderId`),
  KEY `FKakgcl1fas777r82docsj5ec5i` (`productId`)
) ENGINE=MyISAM AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetail`
--

LOCK TABLES `orderdetail` WRITE;
/*!40000 ALTER TABLE `orderdetail` DISABLE KEYS */;
INSERT INTO `orderdetail` VALUES (61,32000,1,'M',NULL,32000,65,17),(62,38000,1,'M','Trân châu trắng,Kem sữa Macchiaito',21000,66,9),(63,28000,1,'M',NULL,28000,67,20),(64,28000,1,'M',NULL,28000,68,20),(65,15000,1,'S',NULL,15000,69,10),(66,28000,1,'M',NULL,28000,70,20),(67,28000,1,'M',NULL,28000,70,15),(68,25000,1,'S',NULL,25000,71,14),(69,28000,1,'M',NULL,28000,72,20),(70,23300,1,'S','Trân châu trắng',13300,73,12),(71,32800,2,'S','Full thạch',8400,74,10),(72,27400,1,'M','Pudding(Socola/Trứng)',22400,74,15),(73,28000,1,'M',NULL,28000,75,20),(74,28000,1,'M',NULL,28000,76,20),(75,28000,1,'M',NULL,28000,77,20),(76,28000,1,'M',NULL,28000,78,20),(77,50000,2,'S',NULL,25000,79,14),(78,25000,1,'S',NULL,25000,80,14),(79,32000,1,'M',NULL,32000,81,21),(80,28000,1,'M',NULL,28000,82,20),(81,31300,1,'S','Full thạch,Trân châu trắng',13300,83,12);
/*!40000 ALTER TABLE `orderdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderDate` date DEFAULT NULL,
  `shippingDate` datetime DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `totalPrice` double NOT NULL,
  `customerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1ptw1l1kw6lk5o8mve55enocc` (`customerId`)
) ENGINE=MyISAM AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (65,'2019-11-12','2019-11-12 20:31:12','CANCELED',32000,10),(66,'2019-11-12','2019-11-12 20:51:17','CANCELED',38000,10),(67,'2019-11-13','2019-11-13 13:59:25','DONE',28000,10),(68,'2019-11-13','2019-11-13 14:28:22','CANCELED',28000,10),(69,'2019-11-13','2019-11-13 14:30:13','CANCELED',15000,10),(70,'2019-11-13','2019-11-13 14:45:13','CANCELED',56000,10),(71,'2019-11-13','2019-11-13 15:40:36','CANCELED',25000,11),(72,'2019-11-14','2019-11-15 22:16:15','DONE',28000,10),(73,'2019-11-15','2019-11-15 16:07:27','DONE',23300,12),(74,'2019-11-15','2019-11-15 21:15:30','MAKING',60200,13),(75,'2019-11-15','2019-11-15 21:21:36','CANCELED',28000,13),(76,'2019-11-15','2019-11-15 21:29:00','CANCELED',28000,13),(77,'2019-11-15','2019-11-15 21:35:15','CANCELED',28000,13),(78,'2019-11-15','2019-11-15 21:35:45','CANCELED',28000,13),(79,'2019-11-15','2019-11-15 21:39:17','CANCELED',50000,13),(80,'2019-11-15','2019-11-15 21:42:20','NEW',25000,14),(81,'2019-11-15','2019-11-15 21:59:30','MAKING',32000,10),(82,'2019-11-15','2019-11-15 22:03:11','NEW',28000,10),(83,'2019-11-15','2019-11-15 22:25:40','DONE',31300,12);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `price` double NOT NULL,
  `status` bit(1) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1mtsbur82frn64de7balymq9s` (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (8,'cà phê đen',12000,_binary '',4,'Nguyên liệu: Café hạt Arabica nguyên chất 100% được xay tại chỗ, đường trắng, đã viên (tùy chọn)'),(9,'cà phê sữa',14000,_binary '',4,'Cà phê phin kết hợp cũng sữa đặc là một sáng tạo đầy tự hào của người Việt, được xem món uống thương hiệu của Việt Nam'),(10,'cà phê đen sài gòn',15000,_binary '',4,'Khắp các ngõ hẻm cho đến đường lớn ở thành phố, bạn dễ dàng bắt gặp hình ảnh ly cà phê gắn bó trong đời sống người dân suốt nhiều năm qua.'),(11,'cà phê sữa sài gòn',19000,_binary '',4,'Cà phê sữa đá có mặt khắp nơi ở Sài Gòn, từ quán cóc bên đường đến nhà hàng sang trọng, bất kể sáng sớm hay chiều tối, đã trở thành một nét văn hóa rất riêng của thành phố'),(12,'Bạc xỉu(Nóng/Đá)',19000,_binary '',4,'Bạc sỉu là một trong những thức uống độc đáo nhất sinh ra ở Sài Gòn, là sản phẩm pha trộn của ba nền văn hóa Hoa-Việt-Pháp'),(13,'cà phê dừa',28000,_binary '',4,'Cà phê cốt dừa được yêu thích bởi vị cà phê đặc trưng và nước cốt dừa thơm lừng, béo ngậy.'),(14,'ca cao(Nóng/Đá)',25000,_binary '',4,'Mỗi khi bạn mệt mỏi, suy nhược cơ thể hoặc đang bị áp lực tinh thần - thể chất trong công việc, hãy thử uống một ly cacao và thư giãn cơ thể, ngủ một giấc thật sâu. Bạn sẽ cảm thấy tràn trề năng lượng hơn, để đối mặt mọi khó khăn một cách nhẹ nhàng nhất.'),(15,'trà hoa nhài kem sữa',21000,_binary '',6,'Trà nhài kem mousse là sự kết hợp giữa vị thanh của hoa nhài, cùng vị mặn của kem sữa là sự lựa chọn hoàn hảo cho buổi chiều nóng nực này'),(16,'trà Olong kem sữa',25000,_binary '',6,'Trà Ô Long sữa đặc biệt ấn tượng với hương thơm như kem sữa, vị bơ mịn, nước trà xanh trong tươi mát.'),(17,'trà đào kem sữa',25000,_binary '',6,'Trà đào xay mang vị trà đen đặc trưng của Teaffee, được khuấy đều cùng sữa chua, thêm vài miếng đào thơm ngon và phủ trên bề mặt bằng lớp kem sữa tươi béo ngậy'),(18,'trà xoài kem sữa',25000,_binary '',6,''),(19,'tra hoa đậu biết kem sữa',25000,_binary '',6,'Trà sữa hoa đậu biếc là thức uống mới nổi, thu hút người thưởng thức bằng vị béo ngậy, chan chát của trà sữa, hương thơm thoang thoảng và đặc biệt là màu tím đặc trưng từ hoa đậu biếc khô'),(20,'trà earl grey kem sữa',21000,_binary '',6,'Vị trà mang vị thơm nồng chiết xuất từ quả Bergamot kết hợp cùng lớp kem sữa mặn đem đến trải nghiệm mới lạ'),(21,'matcha cheese milk foam',25000,_binary '',6,''),(22,'trà đào',22000,_binary '',7,''),(23,'trà đào cam sả',29000,_binary '',7,''),(24,'trà ổi hồng',25000,_binary '',4,''),(25,'trà kiwi',23000,_binary '',7,''),(26,'trà gừng',13000,_binary '',7,''),(27,'trà lipton hạt chia',15000,_binary '',7,''),(28,'matcha đá xay',25000,_binary '',9,''),(29,'caramel đá xay',25000,_binary '',9,''),(30,'socola đá xay',25000,_binary '',9,''),(31,'dâu tây đá xay',25000,_binary '',9,''),(32,'việt quất đá xay',27000,_binary '',9,''),(33,'mojito classic',19000,_binary '',5,''),(34,'mojito mint',19000,_binary '',5,''),(35,'soda táo xanh',19000,_binary '',5,''),(36,'soda việt quất',19000,_binary '',5,''),(37,'cóc ép',15000,_binary '',10,''),(38,'dứa ép',18000,_binary '',10,''),(39,'cam ép',25000,_binary '',10,''),(40,'ổi ép',15000,_binary '',10,''),(41,'sữa tươi kem trứng',25000,_binary '',11,''),(42,'sữa tươi machito',25000,_binary '',11,''),(43,'trà sữa khoai lang tím',25000,_binary '',11,''),(44,'sữa tươi trân châu đường đen',18000,_binary '',11,''),(45,'sữa chua đá',13000,_binary '',12,''),(46,'sữa chua dâu tây',18000,_binary '',12,''),(47,'sữa chua việt quất',20000,_binary '',12,''),(48,'sữa chua chanh dây',18000,_binary '',12,''),(49,'khô gà lá Chanh',30000,_binary '',13,''),(50,'Cốc, Ổi xí muội',22000,_binary '',13,''),(51,'Bánh tráng cuộn vị gà',18000,_binary '',13,'');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `add_star_after_insert_product` AFTER INSERT ON `product` FOR EACH ROW BEGIN
		INSERT INTO vote
        VALUE(default, 5, 1, NEW.id);
	END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `promotion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `discount` varchar(255) DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion`
--

LOCK TABLES `promotion` WRITE;
/*!40000 ALTER TABLE `promotion` DISABLE KEYS */;
INSERT INTO `promotion` VALUES (5,'Khuyến mãi khai trương','0.3','2019-11-30','resources/images/landingPage/products/banner.png','2019-11-01',_binary ''),(6,'Khuyễn mãi tiền 20/11','0.2','2019-11-29','resources/images/landingPage/products/Banner2.jpg','2019-11-01',_binary '');
/*!40000 ALTER TABLE `promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion_product`
--

DROP TABLE IF EXISTS `promotion_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `promotion_product` (
  `product_id` int(11) NOT NULL,
  `promotion_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`promotion_id`),
  KEY `FKeq9krkiyh71kekr3ji9ats5qk` (`promotion_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion_product`
--

LOCK TABLES `promotion_product` WRITE;
/*!40000 ALTER TABLE `promotion_product` DISABLE KEYS */;
INSERT INTO `promotion_product` VALUES (10,5),(10,6),(11,5),(12,5),(15,6),(16,6),(17,6),(18,6),(19,6);
/*!40000 ALTER TABLE `promotion_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ROLE_ADMIN'),(2,'ROLE_USER'),(3,'ROLE_SELLER'),(4,'ROLE_MANAGER');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `size`
--

DROP TABLE IF EXISTS `size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `size` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addition` double NOT NULL,
  `size` varchar(2) DEFAULT NULL,
  `percent` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `size`
--

LOCK TABLES `size` WRITE;
/*!40000 ALTER TABLE `size` DISABLE KEYS */;
INSERT INTO `size` VALUES (1,0,'S',0),(2,7000,'M',0),(3,14000,'L',0);
/*!40000 ALTER TABLE `size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `size_product`
--

DROP TABLE IF EXISTS `size_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `size_product` (
  `product_id` int(11) NOT NULL,
  `size_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`size_id`),
  KEY `FK1cel861ivevbm589o6uyes1h2` (`size_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `size_product`
--

LOCK TABLES `size_product` WRITE;
/*!40000 ALTER TABLE `size_product` DISABLE KEYS */;
INSERT INTO `size_product` VALUES (8,1),(8,2),(9,1),(9,2),(10,1),(10,2),(11,1),(11,2),(12,1),(12,2),(13,1),(13,2),(14,1),(14,2),(15,2),(15,3),(16,2),(16,3),(17,2),(17,3),(18,2),(18,3),(19,2),(19,3),(20,2),(20,3),(21,2),(21,3),(22,2),(22,3),(23,2),(23,3),(24,2),(24,3),(25,2),(25,3),(26,2),(26,3),(27,2),(27,3),(28,2),(28,3),(29,2),(29,3),(30,2),(30,3),(31,2),(31,3),(32,2),(32,3),(33,2),(33,3),(34,2),(34,3),(35,2),(35,3),(36,2),(36,3),(37,2),(37,3),(38,2),(38,3),(39,2),(39,3),(40,2),(40,3),(41,2),(41,3),(42,2),(42,3),(43,2),(43,3),(44,2),(44,3),(45,2),(45,3),(46,2),(46,3),(47,2),(47,3),(48,2),(48,3),(49,1),(50,1),(51,1);
/*!40000 ALTER TABLE `size_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topping`
--

DROP TABLE IF EXISTS `topping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `topping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `price` double NOT NULL,
  `status` bit(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topping`
--

LOCK TABLES `topping` WRITE;
/*!40000 ALTER TABLE `topping` DISABLE KEYS */;
INSERT INTO `topping` VALUES (1,'Full thạch',8000,_binary ''),(2,'Trân châu đen',5000,_binary ''),(3,'Trân châu trắng',10000,_binary ''),(4,'Khúc bạch',5000,_binary ''),(6,'Kem sữa Macchiaito',7000,_binary ''),(7,'Pudding(Socola/Trứng)',5000,_binary ''),(8,'Khoai dẻo',7000,_binary ''),(9,'Quả đào ngâm',7000,_binary ''),(10,'Nha đam',5000,_binary '');
/*!40000 ALTER TABLE `topping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topping_orderdetail`
--

DROP TABLE IF EXISTS `topping_orderdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `topping_orderdetail` (
  `orderDetail_id` int(11) NOT NULL,
  `topping_id` int(11) NOT NULL,
  PRIMARY KEY (`orderDetail_id`,`topping_id`),
  KEY `FKt8ivf64lbmdpoju19o706hrad` (`topping_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topping_orderdetail`
--

LOCK TABLES `topping_orderdetail` WRITE;
/*!40000 ALTER TABLE `topping_orderdetail` DISABLE KEYS */;
INSERT INTO `topping_orderdetail` VALUES (62,3),(62,6),(70,3),(71,1),(72,7),(81,1),(81,3);
/*!40000 ALTER TABLE `topping_orderdetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote`
--

DROP TABLE IF EXISTS `vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `vote` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `star` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3lpbkjcr7st82i459lj878t7k` (`account_id`),
  KEY `FKh5477qurpc725lhy6ky00onkc` (`product_id`)
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote`
--

LOCK TABLES `vote` WRITE;
/*!40000 ALTER TABLE `vote` DISABLE KEYS */;
INSERT INTO `vote` VALUES (17,5,1,8),(18,5,1,9),(19,5,1,10),(20,5,1,11),(21,5,1,12),(22,5,1,13),(23,5,1,14),(24,5,1,15),(25,5,1,16),(26,5,1,17),(27,5,1,18),(28,5,1,19),(29,5,1,20),(30,5,1,21),(31,4,4,9),(32,5,4,11),(33,5,1,22),(34,5,1,23),(35,5,1,24),(36,5,1,25),(37,5,1,26),(38,5,1,27),(39,5,1,28),(40,5,1,29),(41,5,1,30),(42,5,1,31),(43,5,1,32),(44,5,1,33),(45,5,1,34),(46,5,1,35),(47,5,1,36),(48,5,1,37),(49,5,1,38),(50,5,1,39),(51,5,1,40),(52,5,1,41),(53,5,1,42),(54,5,1,43),(55,5,1,44),(56,5,1,45),(57,5,1,46),(58,5,1,47),(59,5,1,48),(60,5,1,49),(61,5,1,50),(62,5,1,51);
/*!40000 ALTER TABLE `vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'coffee_shop_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-15 23:39:17

CREATE DATABASE  IF NOT EXISTS `aaronrenner` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `aaronrenner`;
-- MySQL dump 10.13  Distrib 8.0.22, for macos10.15 (x86_64)
--
-- Host: aaronrenner.com    Database: aaronrenner
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_german2_ci NOT NULL COMMENT 'UUID generated by function',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'name of file or title',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'description of image',
  `image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'image, most likely base64',
  `image_size` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'size of original image, like 1920x1080',
  `mime_type` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'the datatype, like image/json image/png',
  `megapixels` double NOT NULL,
  `upload_date` datetime NOT NULL COMMENT 'date and time image appreared on storage, generated when writing to disk',
  `metadata` json DEFAULT NULL COMMENT 'any additional fields found in image data, stored as JSON object of K/V pairs',
  PRIMARY KEY (`id`,`uuid`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `uuid_UNIQUE` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Collection of images';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `view_image`
--

DROP TABLE IF EXISTS `view_image`;
/*!50001 DROP VIEW IF EXISTS `view_image`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_image` AS SELECT 
 1 AS `uuid`,
 1 AS `name`,
 1 AS `description`,
 1 AS `image`,
 1 AS `image_size`,
 1 AS `mime_type`,
 1 AS `megapixels`,
 1 AS `upload_date`,
 1 AS `metadata`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_image_data_without_image`
--

DROP TABLE IF EXISTS `view_image_data_without_image`;
/*!50001 DROP VIEW IF EXISTS `view_image_data_without_image`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_image_data_without_image` AS SELECT 
 1 AS `uuid`,
 1 AS `name`,
 1 AS `description`,
 1 AS `image_size`,
 1 AS `mime_type`,
 1 AS `megapixels`,
 1 AS `upload_date`,
 1 AS `metadata`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'aaronrenner'
--
/*!50003 DROP PROCEDURE IF EXISTS `create_image` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ARenner`@`%` PROCEDURE `create_image`(
	IN imageIn LONGTEXT,
    IN nameIn VARCHAR(255),
    IN descriptionIn VARCHAR(255),
    IN imageSizeIn VARCHAR(13),
    IN mimeTypeIn VARCHAR(45),
    IN megapixelsIn DOUBLE,
    IN metadataIn JSON,
    OUT uuid CHAR(36)
)
BEGIN
	DECLARE exit handler for SQLEXCEPTION
		BEGIN
			ROLLBACK;
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Resource could not be created';
			RESIGNAL;
		END;
		
	SET @newUuid = UUID();
	SET @uploadDate = NOW();
	SET @newMetadata = '{}';
		IF ((TRIM(metadataIn) != '') || (TRIM(metadataIn) != '{}')) THEN
			SET @newMetadata = metadataIn;
		END IF;

	INSERT INTO image(uuid,name,description,image,image_size,mime_type,megapixels,upload_date,metadata
		) VALUES(
			@newUuid, 
			nameIn,
			descriptionIn,
			imageIn,
			imageSizeIn,
			mimeTypeIn,
			megapixelsIn,
			NOW(),
			@newMetadata
		);
		
	SET uuid = @newUuid;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_image_by_uuid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ARenner`@`%` PROCEDURE `delete_image_by_uuid`(
	IN uuidIn CHAR(36)
)
BEGIN
	DECLARE exit handler for SQLEXCEPTION
		BEGIN
			ROLLBACK;
			#SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Resource could not be located';
			RESIGNAL;
		END;
	
	DELETE FROM image
	WHERE uuid = uuidIn COLLATE 'utf8mb4_general_ci';

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_image` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ARenner`@`%` PROCEDURE `get_all_image`()
BEGIN
	SELECT *
    FROM view_image;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_image_pagination` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ARenner`@`%` PROCEDURE `get_all_image_pagination`(
	IN limit_amount int,
    IN page_number int,
    OUT current_limit int,
    OUT current_page int,
    OUT total_records int,
    OUT total_pages int
)
BEGIN
	DECLARE offset_amount INT DEFAULT 0;
    
	IF page_number IS NULL OR page_number = 0
    THEN
        SELECT 1
        INTO page_number;
    END IF;
    
    IF limit_amount IS NULL OR limit_amount = 0
    THEN
        SELECT 6
        INTO limit_amount;
    END IF;
    
    # calculate the offset
    IF page_number > 1
    THEN
        SELECT (limit_amount * (page_number - 1))
        INTO offset_amount;
    END IF;
    
    # export current calculated limit number
    SELECT limit_amount
    INTO current_limit;

	# export current calculated page number
    SELECT page_number
    INTO current_page;
    
    # get the total records
	SELECT COUNT(*)
	INTO total_records
	FROM view_image;
    
    # get the total pages
	SELECT CEILING(total_records / limit_amount)
	INTO total_pages;
    
    # get the records
    SELECT *
    FROM view_image
    LIMIT limit_amount OFFSET offset_amount;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_image_without_image` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ARenner`@`%` PROCEDURE `get_all_image_without_image`()
BEGIN
	SELECT *
    FROM view_image_data_without_image;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_image_by_uuid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ARenner`@`%` PROCEDURE `get_image_by_uuid`(
	IN uuidIn CHAR(36)
)
BEGIN
	DECLARE exit handler for SQLEXCEPTION
		BEGIN
			ROLLBACK;
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Resource could not be located';
			RESIGNAL;
		END;
    
	SELECT *
    FROM view_image
    WHERE uuid = uuidIn COLLATE 'utf8mb4_general_ci';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `put_image_by_uuid` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`ARenner`@`%` PROCEDURE `put_image_by_uuid`(
	IN uuidIn CHAR(36),
	IN imageIn LONGTEXT,
    IN nameIn VARCHAR(255),
    IN descriptionIn VARCHAR(255),
    IN imageSizeIn VARCHAR(13),
    IN mimeTypeIn VARCHAR(45),
    IN megapixelsIn DOUBLE,
    IN metadataIn JSON
)
BEGIN
	DECLARE exit handler for SQLEXCEPTION
		BEGIN
			ROLLBACK;
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Resource could not be located';
			RESIGNAL;
		END;
		
	SET @newMetadata = '{}';
		IF ((TRIM(metadataIn) != '') || (TRIM(metadataIn) != '{}')) THEN
			SET @newMetadata = metadataIn;
		END IF;

	UPDATE image
    SET
		name = nameIn,
		description = descriptionIn,
		image = imageIn,
		image_size = imageSizeIn,
		mime_type = mimeTypeIn,
		megapixels = megapixelsIn,
		upload_date = NOW(),
		metadata = @newMetadata
	WHERE uuid = uuidIn COLLATE 'utf8mb4_general_ci';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_image`
--

/*!50001 DROP VIEW IF EXISTS `view_image`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ARenner`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_image` AS select `image`.`uuid` AS `uuid`,`image`.`name` AS `name`,`image`.`description` AS `description`,`image`.`image` AS `image`,`image`.`image_size` AS `image_size`,`image`.`mime_type` AS `mime_type`,`image`.`megapixels` AS `megapixels`,`image`.`upload_date` AS `upload_date`,`image`.`metadata` AS `metadata` from `image` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_image_data_without_image`
--

/*!50001 DROP VIEW IF EXISTS `view_image_data_without_image`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`ARenner`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `view_image_data_without_image` AS select `image`.`uuid` AS `uuid`,`image`.`name` AS `name`,`image`.`description` AS `description`,`image`.`image_size` AS `image_size`,`image`.`mime_type` AS `mime_type`,`image`.`megapixels` AS `megapixels`,`image`.`upload_date` AS `upload_date`,`image`.`metadata` AS `metadata` from `image` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-16 16:55:26
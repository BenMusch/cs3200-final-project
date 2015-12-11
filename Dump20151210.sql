-- MySQL dump 10.13  Distrib 5.6.24, for osx10.8 (x86_64)
--
-- Host: 127.0.0.1    Database: final_development
-- ------------------------------------------------------
-- Server version	5.6.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `competed_ats`
--

LOCK TABLES `competed_ats` WRITE;
/*!40000 ALTER TABLE `competed_ats` DISABLE KEYS */;
/*!40000 ALTER TABLE `competed_ats` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `set_team_stats` AFTER INSERT ON `competed_ats` FOR EACH ROW
BEGIN
	DECLARE toty FLOAT;
	DECLARE tyear, count INT;
	SELECT year INTO tyear FROM tournaments WHERE id = NEW.tournament_id;
	SELECT team_count INTO count FROM tournaments WHERE id = NEW.tournament_id;
	CALL toty_points(count, NEW.break_round, toty);
	IF EXISTS(SELECT * FROM team_stats
	WHERE team_id = NEW.team_id and year = tyear)
		THEN UPDATE team_stats
			SET toty_points = IFNULL(toty_points, 0) + toty
            WHERE team_id = NEW.team_id and year = tyear;
	ELSE INSERT INTO team_stats(team_id, year, toty_points, created_at, updated_at)
		VALUES (NEW.team_id, tyear, toty, NOW(), NOW());
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_team_stats` BEFORE UPDATE ON `competed_ats` FOR EACH ROW
BEGIN
	DECLARE toty, old_toty FLOAT;
	DECLARE tyear, count INT;

	SELECT team_count INTO count FROM tournaments WHERE id = OLD.tournament_id;

	CALL toty_points(count, NEW.break_round, toty);
	CALL toty_points(count, OLD.break_round, old_toty);
	SELECT year INTO tyear FROM tournaments WHERE id = NEW.tournament_id;
	UPDATE team_stats
	SET toty_points = IFNULL(toty_points, 0) + toty - old_toty
	WHERE team_stats.team_id = NEW.team_id and team_stats.year = tyear;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `remove_team_stats` BEFORE DELETE ON `competed_ats` FOR EACH ROW
BEGIN
	DECLARE toty, old_toty FLOAT;
	DECLARE tyear, count INT;

	SELECT team_count INTO count FROM tournaments WHERE id = OLD.id;

	CALL toty_points(count, OLD.break_round, toty);
	SELECT year INTO tyear FROM tournaments WHERE id = OLD.tournament_id;
	UPDATE team_stats
	SET toty_points = IFNULL(toty_points, 0) - toty
	WHERE team_stats.team_id = OLD.team_id and team_stats.year = tyear;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `debated_ats`
--

LOCK TABLES `debated_ats` WRITE;
/*!40000 ALTER TABLE `debated_ats` DISABLE KEYS */;
/*!40000 ALTER TABLE `debated_ats` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `set_debater_stats` AFTER INSERT ON `debated_ats` FOR EACH ROW
BEGIN
	DECLARE noty, soty FLOAT;
	DECLARE tyear, count, ncount INT;
	SELECT year INTO tyear FROM tournaments WHERE id = NEW.tournament_id;
	SELECT team_count into count FROM tournaments WHERE id = NEW.tournament_id;
	SELECT novice_count into ncount FROM tournaments WHERE id = NEW.tournament_id;
	CALL soty_points(count, NEW.speaker_award, soty);
	CALL noty_points(ncount, NEW.novice_speaker_award, noty);
	IF EXISTS(SELECT * FROM debater_stats
	WHERE debater_id = NEW.debater_id and year = tyear)
		THEN UPDATE debater_stats
			SET soty_points = IFNULL(soty_points, 0) + soty,
            noty_points = IFNULL(noty_points, 0) + noty
            WHERE debater_id = NEW.debater_id and year = tyear;
	ELSE INSERT INTO debater_stats(debater_id, year, soty_points, noty_points, created_at, updated_at)
		VALUES (NEW.debater_id, tyear, soty, noty, NOW(), NOW());
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_debater_stats` BEFORE UPDATE ON `debated_ats` FOR EACH ROW
BEGIN
	DECLARE noty, soty, old_noty, old_soty FLOAT;
	DECLARE tyear, count, ncount INT;

	SELECT team_count INTO count FROM tournaments WHERE id = OLD.tournament_id;
	SELECT novice_count INTO ncount FROM tournaments WHERE id = OLD.tournament_id;

	CALL soty_points(count, NEW.speaker_award, soty);
	CALL noty_points(ncount, NEW.novice_speaker_award, noty);
	CALL soty_points(count, OLD.speaker_award,  old_soty);
	CALL noty_points(ncount, OLD.novice_speaker_award, old_noty);
	SELECT year INTO tyear FROM tournaments WHERE id = NEW.tournament_id;
	UPDATE debater_stats
	SET soty_points = IFNULL(soty_points, 0) + soty - old_soty,
	noty_points = IFNULL(noty_points, 0) + noty - old_noty
	WHERE debater_stats.debater_id = NEW.debater_id and debater_stats.year = tyear;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `remove_debater_stats` BEFORE DELETE ON `debated_ats` FOR EACH ROW
BEGIN
	DECLARE noty, soty FLOAT;
	DECLARE tyear, count, ncount INT;

	SELECT team_count INTO count FROM tournaments WHERE id = OLD.tournament_id;
	SELECT novice_count INTO ncount FROM tournaments WHERE id = OLD.tournament_id;

	CALL soty_points(count, OLD.speaker_award,  soty);
	CALL noty_points(ncount, OLD.novice_speaker_award, noty);
	SELECT year INTO tyear FROM tournaments WHERE id = OLD.tournament_id;
	UPDATE debater_stats
	SET soty_points = IFNULL(soty_points, 0) - soty,
	noty_points = IFNULL(noty_points, 0) + - noty
	WHERE debater_stats.debater_id = OLD.debater_id and debater_stats.year = tyear;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `debater_stats`
--

LOCK TABLES `debater_stats` WRITE;
/*!40000 ALTER TABLE `debater_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `debater_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `debaters`
--

LOCK TABLES `debaters` WRITE;
/*!40000 ALTER TABLE `debaters` DISABLE KEYS */;
INSERT INTO `debaters` VALUES (26,'2015-12-10 21:39:43','2015-12-10 21:39:43','Rick Dickens'),(27,'2015-12-10 21:39:43','2015-12-10 21:39:43','Marguerite Walter'),(28,'2015-12-10 21:39:43','2015-12-10 21:39:43','Vallie Conroy'),(29,'2015-12-10 21:39:43','2015-12-10 21:39:43','Glen Farrell MD'),(30,'2015-12-10 21:39:43','2015-12-10 21:39:43','Nora O\'Hara'),(31,'2015-12-10 21:39:43','2015-12-10 21:39:43','Flo Leannon V'),(32,'2015-12-10 21:39:43','2015-12-10 21:39:43','Maximilian Oberbrunner'),(33,'2015-12-10 21:39:43','2015-12-10 21:39:43','Josie Bergstrom'),(34,'2015-12-10 21:39:43','2015-12-10 21:39:43','Kelsi Hammes'),(35,'2015-12-10 21:39:43','2015-12-10 21:39:43','Carlo Koss'),(36,'2015-12-10 21:39:43','2015-12-10 21:39:43','Marianne Rogahn DDS'),(37,'2015-12-10 21:39:43','2015-12-10 21:39:43','Ms. Candido Williamson'),(38,'2015-12-10 21:39:43','2015-12-10 21:39:43','Donny Breitenberg IV'),(39,'2015-12-10 21:39:43','2015-12-10 21:39:43','Skye Runolfsson'),(40,'2015-12-10 21:39:43','2015-12-10 21:39:43','Mr. Evert Koss'),(41,'2015-12-10 21:39:43','2015-12-10 21:39:43','Zakary Steuber'),(42,'2015-12-10 21:39:43','2015-12-10 21:39:43','Ariane Beer'),(43,'2015-12-10 21:39:43','2015-12-10 21:39:43','Ed Gulgowski'),(44,'2015-12-10 21:39:43','2015-12-10 21:39:43','Dayton Macejkovic III'),(45,'2015-12-10 21:39:43','2015-12-10 21:39:43','Lenore VonRueden III'),(46,'2015-12-10 21:39:43','2015-12-10 21:39:43','Kaia Abshire'),(47,'2015-12-10 21:39:43','2015-12-10 21:39:43','Mrs. Lyric Denesik'),(48,'2015-12-10 21:39:43','2015-12-10 21:39:43','Darrin Lakin'),(49,'2015-12-10 21:39:43','2015-12-10 21:39:43','Telly Morissette IV'),(50,'2015-12-10 21:39:43','2015-12-10 21:39:43','Alice Franecki');
/*!40000 ALTER TABLE `debaters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `pairings`
--

LOCK TABLES `pairings` WRITE;
/*!40000 ALTER TABLE `pairings` DISABLE KEYS */;
/*!40000 ALTER TABLE `pairings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20151209170723'),('20151209173423'),('20151209173822'),('20151209174014'),('20151209174148'),('20151209174440'),('20151209174557'),('20151209174735'),('20151209174807'),('20151209180047'),('20151209181105');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `team_stats`
--

LOCK TABLES `team_stats` WRITE;
/*!40000 ALTER TABLE `team_stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `teams`
--

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `tournaments`
--

LOCK TABLES `tournaments` WRITE;
/*!40000 ALTER TABLE `tournaments` DISABLE KEYS */;
/*!40000 ALTER TABLE `tournaments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `subtract_oty_points` BEFORE UPDATE ON `tournaments` FOR EACH ROW
BEGIN
	DECLARE soty, noty, toty FLOAT;
	DECLARE cur_id, place, nplace INTEGER;
    DECLARE finished TINYINT DEFAULT 0;
    DECLARE c1 CURSOR FOR (SELECT debater_id FROM debater_stats WHERE debater_id IN
    (SELECT debater_id FROM debated_ats WHERE tournament_id = OLD.id) AND year = OLD.year);
    DECLARE c2 CURSOR FOR (SELECT team_id FROM team_stats WHERE team_id IN
    (SELECT team_id FROM competed_ats WHERE tournament_id = OLD.id) AND year = OLD.year);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    OPEN c1;

    subtract_old: LOOP
		FETCH c1 INTO cur_id;

		IF finished = 1 THEN leave subtract_old;
        END IF;

        SELECT speaker_award INTO place
        FROM debated_ats WHERE tournament_id = OLD.id AND debater_id = cur_id;

		SELECT novice_speaker_award INTO nplace
        FROM debated_ats WHERE tournament_id = OLD.id AND debater_id = cur_id;

        CALL soty_points(OLD.team_count, place, soty);
        CALL noty_points(OLD.novice_count, nplace, noty);

        UPDATE debater_stats
        SET soty_points = soty_points - soty, noty_points = noty_points - noty
        WHERE debater_id = cur_id AND year = OLD.year;
    END LOOP subtract_old;

    CLOSE c1;
    SET finished = 0;
    OPEN c2;

	subtract_old_toty: LOOP
		FETCH c2 INTO cur_id;

		IF finished = 1 THEN leave subtract_old_toty;
        END IF;

        SELECT break_round INTO place
        FROM competed_ats WHERE tournament_id = OLD.id AND team_id = cur_id;

        CALL toty_points(OLD.team_count, place, toty);

        UPDATE team_stats
        SET toty_points = toty_points - toty
        WHERE team_id = cur_id AND year = OLD.year;
    END LOOP subtract_old_toty;
    CLOSE c2;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `add_oty_points` AFTER UPDATE ON `tournaments` FOR EACH ROW
BEGIN
DECLARE soty, noty, toty FLOAT;
	DECLARE cur_id, place, nplace INTEGER;
    DECLARE finished TINYINT DEFAULT 0;
    DECLARE c1 CURSOR FOR (SELECT debater_id FROM debater_stats WHERE debater_id IN
    (SELECT debater_id FROM debated_ats WHERE tournament_id = NEW.id) AND year = NEW.year);
    DECLARE c2 CURSOR FOR (SELECT team_id FROM team_stats WHERE team_id IN
    (SELECT team_id FROM competed_ats WHERE tournament_id = NEW.id) AND year = NEW.year);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    OPEN c1;

    subtract_NEW: LOOP
		FETCH c1 INTO cur_id;

		IF finished = 1 THEN leave subtract_NEW;
        END IF;

        SELECT speaker_award INTO place
        FROM debated_ats WHERE tournament_id = NEW.id AND debater_id = cur_id;

		SELECT novice_speaker_award INTO nplace
        FROM debated_ats WHERE tournament_id = NEW.id AND debater_id = cur_id;

        CALL soty_points(NEW.team_count, place, soty);
        CALL noty_points(NEW.novice_count, nplace, noty);

        UPDATE debater_stats
        SET soty_points = soty_points + soty, noty_points = noty_points + noty
        WHERE debater_id = cur_id AND year = NEW.year;
    END LOOP subtract_NEW;

    CLOSE c1;
    SET finished = 0;
    OPEN c2;

	subtract_NEW_toty: LOOP
		FETCH c2 INTO cur_id;

		IF finished = 1 THEN leave subtract_NEW_toty;
        END IF;

        SELECT break_round INTO place
        FROM competed_ats WHERE tournament_id = NEW.id AND team_id = cur_id;

        CALL toty_points(NEW.team_count, place, toty);

        UPDATE team_stats
        SET toty_points = toty_points + toty
				WHERE team_id = cur_id AND year = NEW.year;
    END LOOP subtract_NEW_toty;
    CLOSE c2;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'final_development'
--

--
-- Dumping routines for database 'final_development'
--
/*!50003 DROP PROCEDURE IF EXISTS `noty_points` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `noty_points`(IN count INT(11), IN place INT(11), OUT points FLOAT)
BEGIN
	DECLARE max_points, temp_points INT;

    IF count < 15 THEN SET max_points = 8;
    ELSEIF count >= 80 THEN SET max_points = 20;
    ELSE SET max_points = FLOOR(count / 8 + 10);
    END IF;

    IF place IS NOT NULL AND place > 0 AND place <=10
		THEN SET points = max_points - (2.5 * (place - 1));
	ELSE SET points = 0;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `soty_points` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `soty_points`(IN count INT(11), IN place INT(11), OUT points FLOAT)
BEGIN
	DECLARE max_points, temp_points INT;

    IF count < 15 THEN SET max_points = 8;
    ELSEIF count >= 80 THEN SET max_points = 20;
    ELSE SET max_points = FLOOR(count / 8 + 10);
    END IF;

    IF place IS NOT NULL AND place > 0 AND place <=10
		THEN SET points = max_points - (2.5 * (place - 1));
		ELSE SET points = 0;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `toty_points` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `toty_points`(IN count INT(11), IN place INT(11), OUT points FLOAT)
BEGIN
	DECLARE max_points INT;
	IF count < 15 THEN SET max_points = 8;
	ELSEIF count >= 80 THEN SET max_points = 20;
	ELSE SET max_points = FLOOR(count / 8 + 10);
	END IF;

	CASE place
	WHEN 0 THEN
		SET points = max_points;
	WHEN 1 THEN
		SET points = max_points - 4;
	WHEN 2 THEN
		IF max_points = 8 THEN SET points = 0;
		ELSE SET points = 9 - (20 - max_points) * 0.75;
		END IF;
	WHEN 3 THEN
		IF max_points < 13 THEN SET points = 0;
		ELSE SET points = 4 - (20 - max_points) * 0.5;
		END IF;
	WHEN 4 THEN
		IF count >= 80 THEN SET points = 1.5;
		ELSEIF count >= 72 THEN SET points = 0.75;
		ELSE SET points = 0;
		END IF;
		ELSE SET points = 0;
	END CASE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-10 21:19:43

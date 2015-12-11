CREATE TABLE `debater_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `debater_id` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `soty_points` int(11) DEFAULT NULL,
  `noty_points` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_debater_stats_on_debater_id` (`debater_id`) USING BTREE,
  CONSTRAINT `debater_stats_debater_id_fk` FOREIGN KEY (`debater_id`) REFERENCES `debaters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

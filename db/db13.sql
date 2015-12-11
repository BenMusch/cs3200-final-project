CREATE TABLE `pairings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT NULL,
  `debater_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_pairings_on_debater_id` (`debater_id`) USING BTREE,
  KEY `index_pairings_on_team_id` (`team_id`) USING BTREE,
  CONSTRAINT `fk_rails_09b29fc8af` FOREIGN KEY (`debater_id`) REFERENCES `debaters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_rails_bbcd6fcd6e` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

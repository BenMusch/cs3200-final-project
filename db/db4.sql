
--
-- Table structure for table `competed_ats`
--

CREATE TABLE `competed_ats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_id` int(11) DEFAULT NULL,
  `tournament_id` int(11) DEFAULT NULL,
  `break_round` int(11) DEFAULT NULL,
  `novice_break_round` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_competed_ats_on_team_id` (`team_id`) USING BTREE,
  KEY `index_competed_ats_on_tournament_id` (`tournament_id`) USING BTREE,
  CONSTRAINT `competed_ats_team_id_fk` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `competed_ats_tournament_id_fk` FOREIGN KEY (`tournament_id`) REFERENCES `tournaments` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

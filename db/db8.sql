CREATE TABLE `debated_ats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `debater_id` int(11) DEFAULT NULL,
  `tournament_id` int(11) DEFAULT NULL,
  `speaker_award` int(11) DEFAULT '0',
  `novice_speaker_award` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_debated_ats_on_debater_id` (`debater_id`) USING BTREE,
  KEY `index_debated_ats_on_tournament_id` (`tournament_id`) USING BTREE,
  CONSTRAINT `debated_ats_debater_id_fk` FOREIGN KEY (`debater_id`) REFERENCES `debaters` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `debated_ats_tournament_id_fk` FOREIGN KEY (`tournament_id`) REFERENCES `tournaments` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

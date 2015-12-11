CREATE TRIGGER `set_debater_stats` AFTER INSERT ON `debated_ats` FOR EACH ROW
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
END

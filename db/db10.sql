CREATE TRIGGER `update_debater_stats` BEFORE UPDATE ON `debated_ats` FOR EACH ROW
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
END

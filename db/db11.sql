CREATE TRIGGER `remove_debater_stats` BEFORE DELETE ON `debated_ats` FOR EACH ROW
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


  DELETE FROM debated_ats
  WHERE tournament_id = OLD.tournament_id
  AND debater_id IN (SELECT debater_id FROM pairings WHERE team_id = OLD.team_id);
END

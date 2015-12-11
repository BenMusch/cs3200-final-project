CREATE TRIGGER `remove_team_stats` BEFORE DELETE ON `competed_ats` FOR EACH ROW
BEGIN
	DECLARE toty, old_toty FLOAT;
	DECLARE tyear, count INT;

	SELECT team_count INTO count FROM tournaments WHERE id = OLD.id;

	CALL toty_points(count, OLD.break_round, toty);
	SELECT year INTO tyear FROM tournaments WHERE id = OLD.tournament_id;
	UPDATE team_stats
	SET toty_points = IFNULL(toty_points, 0) - toty
	WHERE team_stats.team_id = OLD.team_id and team_stats.year = tyear;
END

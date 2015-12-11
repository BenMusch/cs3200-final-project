CREATE TRIGGER `update_team_stats` BEFORE UPDATE ON `competed_ats` FOR EACH ROW
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
END

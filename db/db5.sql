CREATE TRIGGER `set_team_stats` AFTER INSERT ON `competed_ats` FOR EACH ROW
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
END

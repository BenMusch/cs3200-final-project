CREATE TRIGGER `add_oty_points` AFTER UPDATE ON `tournaments` FOR EACH ROW
BEGIN
DECLARE soty, noty, toty FLOAT;
	DECLARE cur_id, place, nplace INTEGER;
    DECLARE finished TINYINT DEFAULT 0;
    DECLARE c1 CURSOR FOR (SELECT debater_id FROM debater_stats WHERE debater_id IN
    (SELECT debater_id FROM debated_ats WHERE tournament_id = NEW.id) AND year = NEW.year);
    DECLARE c2 CURSOR FOR (SELECT team_id FROM team_stats WHERE team_id IN
    (SELECT team_id FROM competed_ats WHERE tournament_id = NEW.id) AND year = NEW.year);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    OPEN c1;

    subtract_NEW: LOOP
		FETCH c1 INTO cur_id;

		IF finished = 1 THEN leave subtract_NEW;
        END IF;

        SELECT speaker_award INTO place
        FROM debated_ats WHERE tournament_id = NEW.id AND debater_id = cur_id;

		SELECT novice_speaker_award INTO nplace
        FROM debated_ats WHERE tournament_id = NEW.id AND debater_id = cur_id;

        CALL soty_points(NEW.team_count, place, soty);
        CALL noty_points(NEW.novice_count, nplace, noty);

        UPDATE debater_stats
        SET soty_points = soty_points + soty, noty_points = noty_points + noty
        WHERE debater_id = cur_id AND year = NEW.year;
    END LOOP subtract_NEW;

    CLOSE c1;
    SET finished = 0;
    OPEN c2;

	subtract_NEW_toty: LOOP
		FETCH c2 INTO cur_id;

		IF finished = 1 THEN leave subtract_NEW_toty;
        END IF;

        SELECT break_round INTO place
        FROM competed_ats WHERE tournament_id = NEW.id AND team_id = cur_id;

        CALL toty_points(NEW.team_count, place, toty);

        UPDATE team_stats
        SET toty_points = toty_points + toty
				WHERE team_id = cur_id AND year = NEW.year;
    END LOOP subtract_NEW_toty;
    CLOSE c2;
END

CREATE PROCEDURE `toty_points`(IN count INT(11), IN place INT(11), OUT points FLOAT)
BEGIN
	DECLARE max_points INT;
	IF count < 15 THEN SET max_points = 8;
	ELSEIF count >= 80 THEN SET max_points = 20;
	ELSE SET max_points = FLOOR(count / 8 + 10);
	END IF;

	CASE place
	WHEN 0 THEN
		SET points = max_points;
	WHEN 1 THEN
		SET points = max_points - 4;
	WHEN 2 THEN
		IF max_points = 8 THEN SET points = 0;
		ELSE SET points = 9 - (20 - max_points) * 0.75;
		END IF;
	WHEN 3 THEN
		IF max_points < 13 THEN SET points = 0;
		ELSE SET points = 4 - (20 - max_points) * 0.5;
		END IF;
	WHEN 4 THEN
		IF count >= 80 THEN SET points = 1.5;
		ELSEIF count >= 72 THEN SET points = 0.75;
		ELSE SET points = 0;
		END IF;
		ELSE SET points = 0;
	END CASE;
END

CREATE PROCEDURE `soty_points`(IN count INT(11), IN place INT(11), OUT points FLOAT)
BEGIN
	DECLARE max_points, temp_points INT;

    IF count < 15 THEN SET max_points = 8;
    ELSEIF count >= 80 THEN SET max_points = 20;
    ELSE SET max_points = FLOOR(count / 8 + 10);
    END IF;

    IF place IS NOT NULL AND place > 0 AND place <=10
		THEN SET points = max_points - (2.5 * (place - 1));
		ELSE SET points = 0;
    END IF;
END

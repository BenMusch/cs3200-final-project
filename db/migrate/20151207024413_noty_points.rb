class NotyPoints < ActiveRecord::Migration
  def change
    execute 'CREATE DEFINER=`root`@`localhost` PROCEDURE `noty_points`(IN tid INT(11), IN place INT(11), OUT points FLOAT)
    BEGIN
    	DECLARE count, max_points, temp_points INT;

        SELECT novice_count INTO count FROM tournaments WHERE id = tid;

        IF count < 15 THEN SET max_points = 8;
        ELSEIF count >= 80 THEN SET max_points = 20;
        ELSE SET max_points = FLOOR(team_count / 8 + 10);
        END IF;

        IF place IS NOT NULL AND place > 0 AND place <=10
    		THEN SET temp_points = max_points - (2.5 * (place - 1));
    	ELSE SET temp_points = 0;
        END IF;
    END'
  end
end

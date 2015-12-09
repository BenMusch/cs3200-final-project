class TheLast < ActiveRecord::Migration
  def change
    execute 'DROP TRIGGER IF EXISTS update_debater_stats;'

    sql = <<-SQL
      CREATE TRIGGER `update_debater_stats` AFTER UPDATE ON `debated_ats` FOR EACH ROW
      BEGIN
      DECLARE noty, soty FLOAT;
      DECLARE tyear INT;
      CALL soty_points(NEW.tournament_id, NEW.speaker_award, soty);
      CALL noty_points(NEW.tournament_id, NEW.novice_speaker_award, noty);
      SELECT year INTO tyear FROM tournaments WHERE tournaments.id = NEW.tournament_id;
        IF EXISTS(SELECT * FROM debater_stats
          WHERE debater_id = NEW.debater_id and year =tyear)
          THEN UPDATE debater_stats
            SET soty_points = soty_points + soty,
            noty_points = noty_points + noty
            WHERE debater_id = NEW.debater_id
            and year = tyear;
        ELSE INSERT INTO debater_stats VALUES (tyear, soty, noty);
      END IF;
      END;
    SQL
    execute sql
  end
end

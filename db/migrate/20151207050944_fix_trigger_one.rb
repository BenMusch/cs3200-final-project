class FixTriggerOne < ActiveRecord::Migration
  def change
    execute 'DROP TRIGGER IF EXISTS update_debater_stats;'

    sql = <<-SQL
      CREATE TRIGGER `update_debater_stats` AFTER UPDATE ON `debated_ats` FOR EACH ROW
      BEGIN
      IF EXISTS(SELECT * FROM debater_stats WHERE debater_id = NEW.debater_id and year =
        (SELECT year FROM tournaments WHERE tournaments.id = NEW.tournament_id LIMIT 1))
        THEN UPDATE debater_stats
        SET soty_points = soty_points + soty_points(NEW.speaker_award),
        noty_points = noty_points(NEW.novice_speaker_award)
        WHERE debater_id = NEW.debater_id
        and year = (SELECT year FROM tournaments WHERE tournaments.id = NEW.tournament_id LIMIT 1);
      ELSE INSERT INTO debater_stats
      VALUES (NEW.debater_id, NEW.tournament.year, soty_points(NEW.speaker_award),
      noty_points(NEW.novice_speaker_award));
      END IF;
      END;
    SQL
    execute sql
  end
end

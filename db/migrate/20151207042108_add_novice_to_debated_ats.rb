class AddNoviceToDebatedAts < ActiveRecord::Migration
  def change
    remove_column :debater_stats, :novice
  end
end

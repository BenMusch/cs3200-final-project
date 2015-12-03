class AddNoviceCountToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :novice_count, :integer
  end
end

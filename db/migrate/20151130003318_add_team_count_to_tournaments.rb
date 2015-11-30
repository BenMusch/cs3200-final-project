class AddTeamCountToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :team_count, :integer
  end
end

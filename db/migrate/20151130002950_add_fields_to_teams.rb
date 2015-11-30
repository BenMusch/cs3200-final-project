class AddFieldsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :team_id, :integer
    add_column :teams, :toty_points, :integer
  end
end

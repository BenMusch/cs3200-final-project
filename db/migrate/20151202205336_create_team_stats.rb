class CreateTeamStats < ActiveRecord::Migration
  def change
    create_table :team_stats do |t|
      t.integer :year
      t.references :team, index: true, foreign_key: true
      t.integer :toty_points

      t.timestamps null: false
    end
  end
end

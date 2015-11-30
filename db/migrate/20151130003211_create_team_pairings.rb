class CreateTeamPairings < ActiveRecord::Migration
  def change
    create_table :team_pairings do |t|
      t.integer :team_id
      t.string :debater

      t.timestamps null: false
    end
  end
end

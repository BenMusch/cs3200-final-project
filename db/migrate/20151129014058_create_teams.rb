class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :debater1
      t.integer :debater2

      t.timestamps null: false
    end
  end
end

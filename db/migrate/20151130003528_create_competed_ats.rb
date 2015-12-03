class CreateCompetedAts < ActiveRecord::Migration
  def change
    create_table :competed_ats do |t|
      t.references :team, index: true, foreign_key: true
      t.references :tournament, index: true, foreign_key: true
      t.integer :break_round
      t.integer :novice_break_round

      t.timestamps null: false
    end
  end
end

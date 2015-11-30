class CreateCompetedAts < ActiveRecord::Migration
  def change
    create_table :competed_ats do |t|
      t.references :team, index: true, foreign_key: true
      t.integer :break_round
      t.references :tournament, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

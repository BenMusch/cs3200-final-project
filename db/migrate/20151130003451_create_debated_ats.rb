class CreateDebatedAts < ActiveRecord::Migration
  def change
    create_table :debated_ats do |t|
      t.references :debater, index: true, foreign_key: true
      t.references :tournament, index: true, foreign_key: true
      t.integer :speaker_award
      t.integer :novice_place

      t.timestamps null: false
    end
  end
end

class CreateDebatedAts < ActiveRecord::Migration
  def change
    create_table :debated_ats do |t|
      t.string :debater
      t.integer :speaker_award
      t.integer :novice_speaker_award

      t.timestamps null: false
    end
  end
end

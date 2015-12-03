class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.references :team, index: true, foreign_key: true
      t.references :debater, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

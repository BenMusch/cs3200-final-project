class CreateDebaterStats < ActiveRecord::Migration
  def change
    create_table :debater_stats do |t|
      t.references :debater, index: true, foreign_key: true
      t.integer :year
      t.boolean :novice
      t.integer :soty_points
      t.integer :noty_points

      t.timestamps null: false
    end
  end
end

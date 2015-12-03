class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.integer :year
      t.integer :team_count

      t.timestamps null: false
    end
  end
end

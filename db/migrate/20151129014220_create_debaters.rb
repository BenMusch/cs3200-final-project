class CreateDebaters < ActiveRecord::Migration
  def change
    create_table :debaters do |t|
      t.timestamps null: false
    end
  end
end

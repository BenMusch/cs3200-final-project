class AddIndexes < ActiveRecord::Migration
  def change
    add_index :debaters, :name, unique: true
  end
end

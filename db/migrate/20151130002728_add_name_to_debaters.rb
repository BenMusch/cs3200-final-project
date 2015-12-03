class AddNameToDebaters < ActiveRecord::Migration
  def change
    add_column :debaters, :name, :string
    add_column :debaters, :hybrid, :boolean
  end
end

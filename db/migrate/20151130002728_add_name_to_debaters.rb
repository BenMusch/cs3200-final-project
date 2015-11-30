class AddNameToDebaters < ActiveRecord::Migration
  def change
    add_column :debaters, :name, :string
    add_column :debaters, :novice, :boolean
    add_column :debaters, :hybrid, :boolean
    add_column :debaters, :soty_points, :integer
    add_column :debaters, :noty_points, :integer
  end
end

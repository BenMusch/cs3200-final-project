class UpdateDefaults < ActiveRecord::Migration
  def change
    change_column :debaters, :name, :string, default: "Test Person"
  end
end

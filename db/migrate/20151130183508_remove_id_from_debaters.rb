class RemoveIdFromDebaters < ActiveRecord::Migration
  def change
    remove_column :debaters, :id
  end
end

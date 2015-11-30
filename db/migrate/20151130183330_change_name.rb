class ChangeName < ActiveRecord::Migration
  def change
    change_column_null :debaters, :name, false
  end
end

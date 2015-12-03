class RemoveDebaterColumns < ActiveRecord::Migration
  def change
    remove_column :teams, :debater1
    remove_column :teams, :debater2
  end
end

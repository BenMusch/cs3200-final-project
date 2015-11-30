class AddYearToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :year, :integer
  end
end

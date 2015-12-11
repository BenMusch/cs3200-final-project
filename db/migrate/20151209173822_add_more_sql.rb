class AddMoreSql < ActiveRecord::Migration
  def change
    execute File.read("db/db3.sql")
  end
end

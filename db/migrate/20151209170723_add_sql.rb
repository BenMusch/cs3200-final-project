class AddSql < ActiveRecord::Migration
  def change
    execute File.read("db/db.sql")
  end
end

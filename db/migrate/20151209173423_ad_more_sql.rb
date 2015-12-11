class AdMoreSql < ActiveRecord::Migration
  def change
    execute File.read("db/db2.sql")
  end
end

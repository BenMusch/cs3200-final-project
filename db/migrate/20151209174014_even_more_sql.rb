class EvenMoreSql < ActiveRecord::Migration
  def change
    execute File.read("db/db4.sql")
  end
end

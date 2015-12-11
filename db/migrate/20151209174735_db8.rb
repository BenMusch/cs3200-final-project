class Db8 < ActiveRecord::Migration
  def change
    execute File.read("db/db8.sql")
  end
end

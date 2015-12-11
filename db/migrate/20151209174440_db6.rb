class Db6 < ActiveRecord::Migration
  def change
    execute File.read("db/db6.sql")
  end
end

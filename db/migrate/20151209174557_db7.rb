class Db7 < ActiveRecord::Migration
  def change
    execute File.read("db/db7.sql")
  end
end

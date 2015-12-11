class Db9 < ActiveRecord::Migration
  def change
    execute File.read("db/db9.sql")
  end
end

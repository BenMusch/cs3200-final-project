class Db5 < ActiveRecord::Migration
  def change
    execute File.read("db/db5.sql")
  end
end

class Oops < ActiveRecord::Migration
  def change
    (10..15).each do |i|
      execute File.read("db/db#{i}.sql")
    end
  end
end

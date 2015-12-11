class FinishSql < ActiveRecord::Migration
  def change
    (16..20).each do |i|
      execute File.read("db/db#{i}.sql")
    end
  end
end

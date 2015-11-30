class AddTournamentToDebatedAt < ActiveRecord::Migration
  def change
    add_reference :debated_ats, :tournament, index: true, foreign_key: true
  end
end

class RenameStuff < ActiveRecord::Migration
  def change
    rename_column :debated_ats, :novice_place, :novice_speaker_award
  end
end

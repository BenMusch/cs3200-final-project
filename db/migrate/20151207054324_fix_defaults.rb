class FixDefaults < ActiveRecord::Migration
  def change
    change_column_default :debated_ats, :novice_speaker_award, 0
    change_column_default :debated_ats, :speaker_award, 0
  end
end

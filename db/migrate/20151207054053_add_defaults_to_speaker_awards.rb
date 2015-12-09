class AddDefaultsToSpeakerAwards < ActiveRecord::Migration
  def change
    change_column_default :debated_ats, :novice_speaker_award, nil
    change_column_default :debated_ats, :speaker_award, nil
  end
end

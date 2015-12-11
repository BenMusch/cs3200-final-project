class Pairing < ActiveRecord::Base
  belongs_to :team, dependent: :destroy
  belongs_to :debater

  validate :not_same_person, :two_people

  private

  def not_same_person
    if Pairing.where(team_id: self.team_id, debater_id: self.debater_id)
      errors.add(:debater, " is the same")
    end
  end

  def two_people
    if Pairing.where(team_id: self.team_id).size == 2
      errors.add(:team, " already has two people")
    end
  end
end

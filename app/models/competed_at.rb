class CompetedAt < ActiveRecord::Base
  belongs_to :team
  belongs_to :tournament
  has_many :debaters, through: :team
  accepts_nested_attributes_for :team
  validate :not_same_debater_at_tournament

  def not_same_debater_at_tournament
    self.debaters.each do |d|
      if d.tournaments.map(&:id).include?(self.tournament_id)
        errors.add(:team, " has a debater who is already paired with another" +
        " team at this tournament")
      end
    end
  end
end

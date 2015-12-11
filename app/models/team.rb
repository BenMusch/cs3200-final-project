class Team < ActiveRecord::Base
  has_many :pairings, dependent: :destroy
  has_many :debaters, through: :pairings
  has_many :team_stats, dependent: :destroy
  has_many :competed_ats, dependent: :destroy
  has_many :tournaments, through: :competed_ats

  validates :name, presence: true

  accepts_nested_attributes_for :pairings

  def to_s
    self.debaters.map(&:name).join (" & ")
  end
end

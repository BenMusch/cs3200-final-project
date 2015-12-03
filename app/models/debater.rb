class Debater < ActiveRecord::Base
  has_many :debater_stats, dependent: :destroy
  has_many :debated_ats, dependent: :destroy
  has_many :tournaments, through: :debated_ats
  has_many :teams, through: :pairings
end

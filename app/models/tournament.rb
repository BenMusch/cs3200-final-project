class Tournament < ActiveRecord::Base
  has_many :competed_ats, dependent: :destroy
  has_many :debated_ats, dependent: :destroy
  has_many :debaters, through: :debated_ats
  has_many :teams, through: :competed_ats

  validates :name, presence: true
  validates :year, presence: true, numericality: true
end

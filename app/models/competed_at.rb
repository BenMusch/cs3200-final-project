class CompetedAt < ActiveRecord::Base
  belongs_to :team
  belongs_to :tournament
  accepts_nested_attributes_for :team
end

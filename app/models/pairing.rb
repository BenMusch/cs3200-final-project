class Pairing < ActiveRecord::Base
  belongs_to :team
  belongs_to :debater
end

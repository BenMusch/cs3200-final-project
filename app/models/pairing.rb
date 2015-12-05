class Pairing < ActiveRecord::Base
  belongs_to :team, dependent: :destroy
  belongs_to :debater
end

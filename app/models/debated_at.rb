class DebatedAt < ActiveRecord::Base
  belongs_to :debater
  belongs_to :tournament
end

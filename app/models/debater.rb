class Debater < ActiveRecord::Base
  self.primary_key = 'name'

  def to_param
    self.name.paramaterize
  end
end

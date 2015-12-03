module ApplicationHelper
  def to_tournament_round(num)
    case num
    when nil
      "No Break"
    when 0
      "Champion"
    when 1
      "Finalist"
    when 2
      "Semi-Finalist"
    when 3
      "Quarter-Finalist"
    when 4
      "Octo-Finalist"
    end
  end

  def get_partner(tournament, debater)
    tournament.competed_ats.each do |entry|
      team = entry.team
      if team.debaters.where(id: debater.id)
        return team.debaters.where.not(id: debater.id).first
      end
    end
    nil
  end
end

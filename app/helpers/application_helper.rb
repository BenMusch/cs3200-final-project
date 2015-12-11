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
    debater.competed_ats.each do |entry|
      if entry.tournament_id == tournament.id
        return entry.team.debaters.where.not(id: debater.id).first
      end
    end
    nil
  end

  def get_individual_results(year, debater_id)
    debater = Debater.find(debater_id)
    results = []
    debater.debated_ats.each do |entry|
      tournament = Tournament.where(id: entry.tournament_id, year: year).first
      if entry.speaker_award && entry.speaker_award > 0  && tournament
        str = tournament.name
        case entry.speaker_award
        when 1
          str += " - 1st speaker"
        when 2
          str += " - 2nd speaker"
        when 3
          str += " - 3rd speaker"
        else
          str += " - #{entry.speaker_award}th speaker"
        end
        results += [str]
      end
    end
    results
  end

  def get_novice_results(year, debater_id)
    debater = Debater.find(debater_id)
    results = []
    debater.debated_ats.each do |entry|
      tournament = Tournament.where(id: entry.tournament_id, year: year).first
      if entry.novice_speaker_award && entry.novice_speaker_award > 0 && tournament
        str = tournament.name
        case entry.novice_speaker_award
        when 1
          str += " - 1st novice"
        when 2
          str += " - 2nd novice"
        when 3
          str += " - 3rd novice"
        else
          str += " - #{entry.novice_speaker_award}th novice"
        end
      end
      results += [str] if str
    end
    results
  end
end

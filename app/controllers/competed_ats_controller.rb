class CompetedAtsController < ApplicationController
  def new
    @entry = CompetedAt.new
    team = Team.new
    @entry.team = team
    2.times { team.pairings.build }
    @tournament = Tournament.find(params[:tournament_id])
    @debaters = Debater.all
    @novice_rounds = novice_rounds
    @rounds = varsity_rounds
  end

  def create
    team = find_team_if_exists
    ps = competed_at_params
    if team
      params = {
        tournament_id:      ps[:tournament_id],
        break_round:        ps[:break_round],
        novice_break_round: ps[:novice_break_round],
        team_id:            team.id
      }
      @entry = CompetedAt.where(tournament_id: ps[:tournament_id], team_id: team.id).first
      if @entry
        @entry.update_attributes(params)
      else
        @entry = CompetedAt.new(tournament_id:      ps[:tournament_id],
                                break_round:        ps[:break_round],
                                novice_break_round: ps[:novice_break_round],
                                team_id:            team.id)
      end
    else
      @entry = CompetedAt.new(competed_at_params)
    end
    if team && @entry.save
      DebatedAt.find_or_create_by(tournament_id: ps[:tournament_id],
                     debater_id: ps[:team_attributes][:pairings_attributes]['0'][:debater_id])
      DebatedAt.find_or_create_by(tournament_id: ps[:tournament_id],
                     debater_id: ps[:team_attributes][:pairings_attributes]['1'][:debater_id])
      redirect_to @entry.tournament
    else
      redirect_to new_tournament_competed_at_path(tournament_id: ps[:tournament_id])
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @comp = CompetedAt.find(params[:id])
    tid = @comp.tournament_id
    @comp.destroy
    redirect_to tournament_path(id: tid)
  end

  private

  def competed_at_params
    params.require(:competed_at).permit(:tournament_id, :break_round,
                                        :novice_break_round,
                                        team_attributes: [
                                            :id,
                                            pairings_attributes: [
                                              :id,
                                              :team_id,
                                              :debater_id
                                            ]
                                          ])
  end

  class BreakRound
    attr_accessor :title, :value

    def initialize(title, value)
      @title = title
      @value = value
    end
  end

  def varsity_rounds
    [
      BreakRound.new("No Break", nil),
      BreakRound.new("Winner", 0),
      BreakRound.new("Finalist", 1),
      BreakRound.new("Semi-Finalist", 2),
      BreakRound.new("Quarter-Finalist", 3),
      BreakRound.new("Octo-Finalist", 4)
    ]
  end

  def novice_rounds
    [
      BreakRound.new("No Break", nil),
      BreakRound.new("Winner", 0),
      BreakRound.new("Finalist", 1),
      BreakRound.new("Semi-Finalist", 2),
      BreakRound.new("Quarter-Finalist", 3)
    ]
  end

  def find_team_if_exists
    pairing_params = competed_at_params[:team_attributes][:pairings_attributes]
    pairings = Pairing.where(debater_id: pairing_params['0'][:debater_id])
    pairings.each do |pairing|
      team = pairing.team
      team.pairings.each do |p2|
        if p2.debater_id == pairing_params['1'][:debater_id].to_i
          unless p2.debater_id == pairing.debater_id
            return team
          end
        end
      end
    end
    nil
  end
end

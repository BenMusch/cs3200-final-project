class DebatedAtsController < ApplicationController
  def new
    @entry = DebatedAt.new
    @tournament = Tournament.find(params[:tournament_id])
    @debaters = @tournament.debaters
  end

  def create
    @entry = DebatedAt.find_by(debated_at_params[:_id])
    if @entry.update_attributes(debated_at_params)
      redirect_to tournament_path(id: @entry.tournament_id)
    else
      redirect_to root_path
    end
  end

  def edit
    @entry = DebatedAt.find_by(params[:id])
    @tournament = Tournament.find(params[:tournament_id])
    @debaters = @tournament.debaters
  end

  def update
    @entry = DebatedAt.find_by(tournament_id: debated_at_params[:tournament_id],
                               debater_id:    debated_at_params[:debater_id])
    if @entry.update_attributes(debated_at_params)
      redirect_to tournament_path(id: @entry.tournament_id)
    else
      redirect_to root_path
    end
  end

  private

  def debated_at_params
    params.require(:debated_at).permit(:debater_id,           :tournament_id,
                                       :novice_speaker_award, :speaker_award)
  end
end

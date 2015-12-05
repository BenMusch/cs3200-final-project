class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
    if params[:year]
      @tournaments = @tournaments.where(year: params[:year])
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
  end

  def update
    @tournament = Tournament.find(params[:id])
    if @tournament.update_attributes(tournament_params)
      flash[:success] = "Case updated"
      redirect_to @tournament
    else
      render 'edit'
    end
  end

  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
    redirect_to tournaments_path, method: :get
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to @tournament
    else
      flash[:danger] = "Error creating tournament"
      redirect_to new_tournament_path
    end
  end

  def edit
    @tournament = Tournament.find(params[:id])
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :year, :novice_count, :team_count)
  end
end

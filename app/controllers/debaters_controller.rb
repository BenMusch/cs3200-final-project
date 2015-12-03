class DebatersController < ApplicationController
  def index
    if params[:order]
      @debaters = Debater.order(name: params[:order].to_sym)
    else
      @debaters = Debater.all
    end
  end

  def show
    @debater = Debater.find(params[:id])
  end

  def edit
    @debater = Debater.find(params[:id])
  end

  def destroy
    @debater = Debater.find(params[:id])
    @debater.destroy
    redirect_to debaters_path, method: :get
  end

  def new
    @debater = Debater.new
    @debater.name = nil
  end

  def create
    @debater = Debater.new(debater_params)
    if @debater.save
      redirect_to @debater
    else
      flash[:danger] = "Error creating debater"
      redirect_to new_debater_path
    end
  end

  def update
    @debater = Debater.find(params[:id])
    if @debater.update_attributes(debater_params)
      flash[:success] = "Case updated"
      redirect_to @debater
    else
      render 'edit'
    end
  end

  private

  def debater_params
    params.require(:debater).permit(:name, :hybrid)
  end
end

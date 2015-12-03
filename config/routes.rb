Rails.application.routes.draw do
  get 'teams/index'

  root 'application#index'

  resources :debaters
  resources :teams, only: :index
  resources :tournaments do
    resources :competed_ats, only: [:new, :create, :edit, :update, :destroy]
  end
end

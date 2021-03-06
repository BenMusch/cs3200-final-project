Rails.application.routes.draw do
  root 'application#index'

  resources :debaters
  resources :teams, only: [:index, :show]
  resources :tournaments do
    resources :competed_ats, only: [:new, :create, :edit, :update, :destroy]
    resources :debated_ats,  only: [:new, :create, :edit, :update]
  end
end

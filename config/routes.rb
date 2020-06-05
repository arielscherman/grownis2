Rails.application.routes.draw do
  devise_for :users
  root to: "depots#index"

  resources :depots, only: :index
end

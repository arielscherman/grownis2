Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: "depots#index"

  resources :depots, only: :index
end

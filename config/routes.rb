Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: "depots#index"

  namespace :api, constraints: { format: :json } do
    resources :rates, only: :index
  end

  resources :depots, shallow: true do
    scope module: 'depots' do
      resources :movements
    end
  end
end

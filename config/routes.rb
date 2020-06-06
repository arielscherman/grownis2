Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: "depots#index"

  resources :depots, shallow: true do
    scope module: 'depots' do
      resources :movements
    end
  end
end

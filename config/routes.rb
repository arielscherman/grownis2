Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: "depots#index"

  namespace :charts, constraints: { format: :js } do
    scope "/:depot_id" do
      resources :daily_balances, only: :index
    end

    namespace :users do
      resource :consolidated_balance, only: :show
    end
  end

  namespace :api, constraints: { format: :json } do
    resources :rates, only: :index
  end

  resources :movements, only: [:index, :new, :create]

  resources :depots, shallow: true do
    scope module: 'depots' do
      resources :movements
    end
  end
end

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    confirmations: 'users/confirmations' }

  authenticated :user do
    root to: "depots#index", as: :authenticated_root
  end

  root to: "public/welcome#index"

  resources :bugs
  resources :suggestions

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

  resources :movements, only: [:index, :new, :create, :destroy]

  resources :depots, shallow: true do
    scope module: 'depots' do
      resources :movements, only: [:index]
    end
  end
end

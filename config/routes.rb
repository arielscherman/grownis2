Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations',
                                    confirmations: 'users/confirmations' }

  authenticated :user do
    root to: "depots#index", as: :authenticated_root
  end

  root to: "public/welcome#index"

  resources :bugs
  resources :suggestions

  namespace :reports do
    resources :profits, only: :index
    namespace :profits do
      resource :balance, only: :show
      resources :rates, only: :index
      resources :balance_by_depots, only: :index
    end
  end

  namespace :charts, constraints: { format: :js } do
    scope "/:depot_id" do
      resources :daily_balances, only: :index
    end

    resources :rates, only: :show

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

  resources :rates, only: [:index, :show]

  namespace :users, shallow: true do
    resources :messages, only: :update
  end

  get '/404', to: "errors#not_found"
  get '/422', to: "errors#unacceptable"
  get '/500', to: "errors#internal_error"
end

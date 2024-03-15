Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :potato_prices, only: [:index] do
        collection do
          get '/:date', to: 'potato_prices#index'
        end
        scope module: :potato_prices do
          collection do
            get 'best_gain/:date', to: 'best_gain#show'
          end
        end
      end
    end
  end
end

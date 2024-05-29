Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :users, controllers: { sessions: 'api/v1/sessions', registrations: 'api/v1/registrations'}

      resources :brands, only: [:index, :create, :update, :destroy] do
        resources :products
      end
    end
  end
end

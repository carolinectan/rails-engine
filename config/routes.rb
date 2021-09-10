Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      namespace :items do
        resources :find_all, only: [:index], controller: :search
      end

      namespace :merchants do
        resources :find, only: [:index], controller: :search
      end

      get '/revenue/merchants', to: 'merchants#merchant_revenue', controller: :merchants

      # namespace :revenue do
      #   resources :merchants, only: [:index], controller: :top_revenue
      # end

      resources :items, only: [:index, :show, :create, :destroy, :update]

      resources :merchants, only: [:index, :show]

      get '/items/:item_id/merchant', to: 'item_merchant#show'

      get '/merchants/:merchant_id/items', to: 'merchant_items#index'
    end
  end
end

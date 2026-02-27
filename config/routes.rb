Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :orders, only: [:index, :show, :update]
  end

  root "products#index"

  resources :products, only: [ :index, :show ]

  get    "/cart", to: "cart#show"
  post   "/cart/add/:product_id", to: "cart#add", as: :add_cart
  delete "/cart/remove/:product_id", to: "cart#remove", as: :remove_cart

  resources :orders do
    collection do
      post :payment_success
    end
  end

  post "/payments/verify", to: "payments#verify"
end

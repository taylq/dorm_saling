Rails.application.routes.draw do
  devise_for :users, controllers: {confirmations: "confirmations"}
  scope "(:locale)", locale: /en|vi/ do
    get "/pages/*page" => "pages#show"
    root "pages#show", page: "home"

    resources :users do
      resources :messages
    end
    resources :statistical
    resources :orders
    resources :carts
    resources :charges
    resources :products do
      resources :order_details, only: :create
    end
    resources :order_details, only: %i(show destroy edit update)
    resources :notifications
  end
end

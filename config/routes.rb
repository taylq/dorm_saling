Rails.application.routes.draw do
  devise_for :users, controllers: {confirmations: "confirmations"}
  scope "(:locale)", locale: /en|vi/ do
    get "/pages/*page" => "pages#show"
    root "pages#show", page: "home"

    resources :users
    resources :products
    resources :orders
  end
end

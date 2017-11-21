Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users",
    confirmations: "confirmations"}
  scope "(:locale)", locale: /en|vi/ do
    get "/pages/*page" => "pages#show"
    root "pages#show", page: "home"
    devise_scope :user do
      resources :users do
        resources :messages
      end
    end
    resources :notifications
  end
end

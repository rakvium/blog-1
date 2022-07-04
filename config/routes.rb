Rails.application.routes.draw do
  resources :categories

  devise_for :users
  resources :categories

  root "articles#index"
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :articles do
    resources :comments
  end
  resources :users

  get "/search", to: "articles#search"

  scope "admin" do
    delete "users/:id", to: "admin#user_destroy", via: 'delete', as: 'admin_destroy_user'
    get ":id", to: "admin#show",  as: 'admin'

  end
end

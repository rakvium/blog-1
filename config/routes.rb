Rails.application.routes.draw do
  get 'admin/index'
  get 'admin/show'
  get 'admin/edit'
  get 'admin/update'
  get 'admin/new'
  get 'users/show'
  devise_for :users
  root "articles#index"
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :articles do
    resources :comments
  end
  resources :users

  get "/admin/:id", to: "admin#show",  as: 'admin'
  get "/search", to: "articles#search"


end

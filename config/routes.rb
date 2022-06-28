Rails.application.routes.draw do
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
end

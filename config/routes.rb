Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
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
  resources :users do
    resources :phones
  end
  resources :likes, only: [:create, :destroy]
  resources :dislikes, only: [:create, :destroy]
  get "/languages/:language", to: "language#show",  as: 'languages'



  scope "admin" do
    delete "users/:id", to: "admin#user_destroy", via: 'delete', as: 'admin_destroy_user'
    get ":id", to: "admin#show",  as: 'admin'
    get "change_role/:id", to: "admin#change_role",  as: 'admin_change_role'
    patch "make_admin/:id", to: "admin#make_admin", via: 'patch',  as: 'admin_make_admin'
    patch "make_user/:id", to: "admin#make_user", via: 'patch', as: 'admin_make_user'
    patch "make_member/:id", to: "admin#make_member", via: 'patch', as: 'admin_make_member'

    get "article/approve/:id", to: "admin#article_approve",  as: 'admin_article_approve'
    get "article/disapprove/:id", to: "admin#article_disapprove",  as: 'admin_article_disapprove'
  end
end
end

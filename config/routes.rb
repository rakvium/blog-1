# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    resources :categories
    resources :places
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
    resources :categories

    root 'articles#index'
    devise_scope :user do
      get '/users/sign_out' => 'devise/sessions#destroy'
    end
    resources :articles do
      resources :comments
    end
    resources :users do
      resources :phones
    end
    resources :likes, only: %i[create destroy]
    resources :dislikes, only: %i[create destroy]
    get '/languages/:language', to: 'language#show', as: 'languages'
    get '/members_only/articles', to: 'members#articles', as: 'members_only_articles'
    get '/:id/locations', to: 'users#locations', as: 'user_locations'
    get '/explore', to: 'articles#explore', as: 'explore_articles'

    scope controller: :static do
      get :pricing
    end
    get '/success', to: 'purchase/checkouts#success'

    namespace :purchase do
      resources :checkouts
    end

    resources :subscriptions

    scope 'admin' do
      delete 'users/:id', to: 'admin#user_destroy', via: 'delete', as: 'admin_destroy_user'
      get ':id', to: 'admin#show', as: 'admin'
      get 'change_role/:id', to: 'admin#change_role', as: 'admin_change_role'
      patch 'make_admin/:id', to: 'admin#make_admin', via: 'patch', as: 'admin_make_admin'
      patch 'make_user/:id', to: 'admin#make_user', via: 'patch', as: 'admin_make_user'
      patch 'make_member/:id', to: 'admin#make_member', via: 'patch', as: 'admin_make_member'

      get 'article/approve/:id', to: 'admin#article_approve',  as: 'admin_article_approve'
      get 'article/disapprove/:id', to: 'admin#article_disapprove', as: 'admin_article_disapprove'
    end
  end
end

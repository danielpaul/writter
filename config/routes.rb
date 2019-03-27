# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do

  root to: 'articles#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resource :user do
    resources :publications_users
  end
  resources :articles do
    member do
      put 'like', to: 'articles#like'
    end
    resources :comments, module: :articles, only: [:create, :destroy]
  end

  resources :publications do
    resources :publications_users
  end

  resource :publications_users
end

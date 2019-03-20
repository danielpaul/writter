# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root to: 'articles#index'

  devise_for :users
  resources :users, only: [:show]

  resources :articles do
    resources :comments, module: :articles, only: [:create, :destroy]
  end

  mount Notifications::Engine => "/notifications"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

end

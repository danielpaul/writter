# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :articles do
    member do
      put 'like', to: 'articles#like'
    end
    resources :comments, module: :articles, only: [:create, :destroy]
  end

  resources :publications

  root to: 'articles#index'

end

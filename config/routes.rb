Rails.application.routes.draw do
  root to: 'article_search#index'
  get 'search', to: 'article_search#search', as: :article_search
  resources :articles, only: [:index, :show]
  resources :searches, only: [:index]
  get 'top-searches', to: 'searches#top', as: :top_searches
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

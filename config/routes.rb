# frozen_string_literal: true

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root to: 'home#index'
  get 'about', to: 'home#about', as: :about
  get 'contact', to: 'home#contact', as: :contact

  resources :user_files, path: 'files', param: :uuid

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end

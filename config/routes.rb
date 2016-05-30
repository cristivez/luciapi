require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  # Api definition
  namespace :api, defaults: { format: :json }  do
    scope module: :v1,
              constraints: ApiConstraints.new(version: 1, default: true) do

      resources :users, :only => [:create, :update]

      delete 'signout' => 'sessions#destroy'
      get 'userProfile' => 'users#show'
      post 'autopopulate' => 'autopopulates#autopopulate'

      resources :sessions, :only => [:create, :destroy]
    end
  end
end

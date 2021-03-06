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
      get 'test' => 'testapns#test'

     post 'onlineEvent'=> 'oevents#create'
     post 'showOnlineEvents' => 'oevents#show'
     post 'cancelEvent' => 'oevents#delete'

     post 'showEvent' => 'oevents#showEvent'
      resources :sessions, :only => [:create, :destroy]
    end
  end
end

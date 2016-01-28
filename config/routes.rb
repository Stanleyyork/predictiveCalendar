Rails.application.routes.draw do

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/settings' => 'users#edit'
  get '/import_events' => 'users#redirect'
  get '/oauth2callback' => 'users#callback'
  get '/events/create' => 'events#create'
  get '/events' => 'events#index'
  get '/profile' => 'users#show'

end

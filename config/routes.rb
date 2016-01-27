Rails.application.routes.draw do
  get 'events/new'

  get 'events/index'

  get 'events/update'

  get 'events/edit'

  get 'events/destroy'

  get 'events/create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
end

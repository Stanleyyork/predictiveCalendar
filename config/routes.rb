Rails.application.routes.draw do

  get '/' => 'application#homepage'
  get '/about' => 'application#about'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/settings' => 'users#edit'
  post '/settings' => 'users#update'
  get '/delete_calendar' => 'users#delete_calendar'
  get '/delete_account' => 'users#destroy'

  get '/import_events' => 'users#redirect'
  get '/oauth2callback' => 'users#callback'
  get '/events/create' => 'events#create'
  get '/done_syncing' => 'users#done_syncing'
  get '/sync_false' => 'users#sync_false'
  get '/seed_algolia' => 'users#seed_algolia'
  get '/algolia_data' => 'users#algolia_data'

  get '/events' => 'events#index'
  get '/analyze' => 'events#analyze'
  get '/events/:id' => 'events#show'
  get '/ratings' => 'events#ratings'
  post '/setratings' => 'events#update_ratings'
  get '/logreg' => 'events#logreg'
  get '/search' => 'events#search'
  get '/profile' => 'users#show'
  get '/:username' => 'users#show'
  

end

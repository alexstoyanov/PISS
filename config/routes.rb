PISS::Application.routes.draw do

  match '*whatever', :via => [:options, :head], :to => 'options#options'

  # users
  post 'users/create'                   => 'users#create'
  post 'users/update'                   => 'users#update'

  # sessions
  post 'sessions/create'                => 'sessions#create'
  post 'sessions/destroy'               => 'sessions#destroy'
  get 'sessions/current'                => 'sessions#current'
end

ZediskRu::Application.routes.draw do

  devise_for :users

  get '/mark/:id/load_models', to: 'home#load_models'
  get '/model/:id/load_years', to: 'home#load_years'
  get '/year/:id/load_mods', to: 'home#load_mods'

  get '/disks/mod/:id', to: 'home#disks'
  get '/disks', to: 'home#disks_by_params'
  get '/tires', to: 'tyres#index'
  get '/sizes/mod/:id', to: 'home#sizes_index'

  post '/order', to: 'home#order'

  get '/admin', to: 'admin#index'

  root to: 'home#index'
end

Rails.application.routes.draw do
  root to: 'searches#new'
  get '/searches/togglemode', to: 'searches#togglemode', as: 'toggle_mode'
  resources :searches
  resources :documents
  resources :collections
end

Rails.application.routes.draw do
  root to: 'searches#new'
  resources :searches
  resources :documents
  resources :collections
end

Rails.application.routes.draw do
  root to: 'home#show'

  get    '/search',               to: 'home#search',      as: :search

  get    '/auth/github/callback', to: 'sessions#callback'
  get    '/login',                to: 'sessions#create',  as: :login
  delete '/logout',               to: 'sessions#destroy', as: :logout

end

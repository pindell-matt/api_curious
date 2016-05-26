Rails.application.routes.draw do
  root to: 'home#show'

  get    '/search',               to: 'home#search',      as: :search 
  get    '/login',                to: 'sessions#create',  as: :login
  get    '/auth/github/callback', to: 'sessions#callback'
  delete '/logout',               to: 'sessions#destroy', as: :logout

end

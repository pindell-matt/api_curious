Rails.application.routes.draw do
  root to: 'home#show'

  get '/login', to: 'sessions#create', as: :login

  get '/auth/github/callback', to: 'sessions#callback'

end

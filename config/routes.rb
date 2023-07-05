Rails.application.routes.draw do
  resources :users
  resources :bills

  post '/auth/login', to: 'authentication#login'
end

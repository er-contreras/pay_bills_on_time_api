Rails.application.routes.draw do
  post 'bill_notification', to: 'bill_notification#create'

  resources :users
  resources :bills

  post '/auth/login', to: 'authentication#login'
end

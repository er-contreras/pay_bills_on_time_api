require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root 'welcome#index'

  post 'bill_notification', to: 'bill_notification#create'

  resources :users
  resources :bills

  get '/user_bills/:user_id', to: 'bills#user_bills'

  post '/auth/login', to: 'authentication#login'
end

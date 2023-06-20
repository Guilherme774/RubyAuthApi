Rails.application.routes.draw do
  resources :musics
  resource :users, only: [:create]

  post '/login', to: 'users#login'
end

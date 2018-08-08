Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  resources :users, only: [:index, :create, :show]
  resources :conversations, only: [:index, :create]
  resources :chats, only: [:index, :create]
  resources :messages, only: [:create]
  post '/login' => 'users#login'
  post '/get_user' => 'users#get_user'
  mount ActionCable.server => '/cable'

end

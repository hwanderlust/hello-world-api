Rails.application.routes.draw do
  get 'lists/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  resources :users, only: [:index, :create, :show]
  resources :conversations, only: [:index, :create]
  resources :chats, only: [:index, :create]
  resources :messages, only: [:create]
  resources :lists, only: [:create, :show]
  post '/login' => 'users#login'
  post '/get_user' => 'users#get_user'
  post '/translate' => 'messages#translate'
  post '/detect_language' => 'messages#detection'
  get '/users/:id/lists' => 'users#get_lists'
  post '/save_message' => 'messages#add_to_list'

  mount ActionCable.server => '/cable'

end

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'lists/create'
  # resources :conversations, only: [:index, :create]
  # resources :chats, only: [:index, :create, :show]

  resources :users, only: [:index, :create, :show]
  post '/login' => 'users#login'
  post '/get_user' => 'users#get_user'
  get '/users/:id/lists' => 'users#get_lists'
  
  resources :chats, only: [:create, :show]

  resources :messages, only: [:create]
  post '/translate' => 'messages#translate'
  post '/detect_language' => 'messages#detection'
  post '/save_message' => 'messages#add_to_list'
  patch '/save_message' => 'messages#add_to_list'
  post '/remove_message' => 'messages#remove_from_list'

  resources :lists, only: [:create, :show, :destroy]

end

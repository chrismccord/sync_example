SyncExample::Application.routes.draw do
  devise_for :users

  resources :projects do
    resources :todos do
      resources :comments
    end
  end


  resources :users

  root to: 'pages#index'
  get 'update', to: 'pages#update'
end

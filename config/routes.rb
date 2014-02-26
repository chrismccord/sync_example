SyncExample::Application.routes.draw do
  
  devise_for :users

  devise_scope :user do 
    authenticated :user do
      root to: 'projects#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :projects do
    resources :todos do
      resources :comments
    end
  end
  resources :users
end

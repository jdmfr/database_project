Rails.application.routes.draw do
  
  resources :places  do
    resources :appointments
  end

  
  resources :projects do
    member do
      patch 'star'
      put 'star'
    end
  end
  resources :categories
  resources :groups do
    member do
      patch 'star'
      put 'star'
    end
  end
#  resources :comments
  resources :posts do
  	resources :comments 
  end
  resources :relationships, only: [:create, :destroy]
   devise_for :users 
  resources :users do
  	member do
  		get :following,:followers
  	end
  end

  get '/home' => 'pages#home' # override default routes.
   

  get '/user/:id' => 'pages#profile'
  get '/explore' => 'pages#explore'
  get '/index' => 'pages#index'
  root :to =>'pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end

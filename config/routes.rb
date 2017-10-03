Rails.application.routes.draw do
  
  resources :ingredients
  resources :instructions do 
  	resources :users, only: [:show, :index]
  end

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: 'registrations'}
  	resources :users, only: [:show, :index] do
  		resources :instructions, only: [:show, :index, :new, :create, :edit, :update]
  	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 	root to: 'welcome#index'
 	get '/welcome/:id' => 'welcome#show', as: 'welcome'
 	get '/instructions' => 'instructions#index'
  get 'auth/twitter/callback' => 'sessions#create'

end

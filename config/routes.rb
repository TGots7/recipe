Rails.application.routes.draw do
  
  resources :ingredients
  resources :instructions 

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: 'registrations'}
  	resources :users, only: [:show, :index] do
  		resources :instructions, only: [:show, :index, :new, :create, :edit, :update]
  	end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 	root to: 'welcome#index'
 	get '/welcome/:id' => 'welcome#show', as: 'welcome'
  get 'auth/twitter/callback' => 'sessions#create'

  # namespace :admin do 
  #   resources :stats, only: [:index]
  # end

end

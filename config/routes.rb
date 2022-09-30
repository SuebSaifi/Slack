Rails.application.routes.draw do
  get 'users/show'
  resources :channels 
      resources :messages
  devise_for :users
  resources :users
  # Define your application   routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "channels#index"
  patch "accept",to: "invitations#accept"
  resources :invitations
end

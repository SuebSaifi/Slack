Rails.application.routes.draw do
  get 'users/show'
  resources :channels do
    resources :messages
  end
  devise_for :users
  resources :users
  # Define your application   routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "channels#index"
  patch "accept",to: "invitations#accept"
  post "channel_message",to: "channels#message_create"
  resources :invitations
end

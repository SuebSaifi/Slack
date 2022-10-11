Rails.application.routes.draw do
  get 'users/show'
  resources :channels
  resources :messages
  devise_for :users
  resources :users
  root "channels#index"
  patch "accept",to: "invitations#accept"
  post "channel_message",to: "channels#message_create"
  resources :invitations
end

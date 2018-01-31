Rails.application.routes.draw do
  root "pages#home"
  get 'registry', to: 'pages#registry', as: :registry
  get 'rsvp', to: 'pages#rsvp', as: :rsvp
  get 'info', to: 'pages#info', as: :info
  get 'reveal', to: 'reveal#show', as: :reveal
  resources :invite_groups do 
    post :cancel
  end 
end

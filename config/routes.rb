Rails.application.routes.draw do
  resources :blogapp
  root 'pages#home'
  get 'about', to: 'pages#about'
end

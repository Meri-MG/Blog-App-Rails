Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :create, :new, :show]
  end

  resources :posts do
    resources :comments, only: [:create, :new]
    resources :likes, only: [:create]
  end
  root 'pages#home'
end

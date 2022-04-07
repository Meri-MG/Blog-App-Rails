Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :create, :new, :show]
  end

  resources :posts do
    resources :comments, only: [:create, :new]
    resources :likes, only: [:create]
  end
  root 'pages#home'

  delete '/comments/delete', to: 'comments#destroy'
  delete '/users/:user_id/posts/:id/delete', to: 'posts#destroy'
end

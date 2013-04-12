Motivators::Application.routes.draw do

  root :to => 'motivators#index'
  match '/about' => 'pages#about'
  devise_for :users
  ActiveAdmin.routes(self)
  match 'users/:id' => 'users#show', as: :user
  resources :motivators

end

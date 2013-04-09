Motivators::Application.routes.draw do

  root :to => 'motivators#index'
  match '/about' => 'pages#about'
  devise_for :users
  match 'users/:id' => 'users#show', as: :user
  resources :motivators

end

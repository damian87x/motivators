Motivators::Application.routes.draw do
  root :to => 'motivators#index'
  match '/about' => 'pages#about'
  devise_for :users
  resources :motivators
end

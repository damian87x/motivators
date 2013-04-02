Motivators::Application.routes.draw do
  devise_for :users

  root :to => 'pages#home'
  match '/about' => 'pages#about'
end

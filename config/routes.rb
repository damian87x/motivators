Motivators::Application.routes.draw do
  root :to => 'pages#home'
  match '/about' => 'pages#about'
end

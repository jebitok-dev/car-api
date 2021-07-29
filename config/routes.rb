Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :houses do
    resources :favorites
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end

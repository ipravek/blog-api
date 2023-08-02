Rails.application.routes.draw do
  devise_for :users

  
  namespace :api do
    post 'login', to: 'auth#login'
    resources :blogs do
      resources :comments, only: [:create, :index]
    end
  end

end

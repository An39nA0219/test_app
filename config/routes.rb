Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace 'api' do
    resources :posts
    resources :users
    resources :user_sessions, only: [:create, :destroy]
  end
end

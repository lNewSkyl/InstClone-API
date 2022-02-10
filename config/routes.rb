Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users, param: :_username
      post '/auth/login', to: 'authentication#login'
      resources :posts do
        resources :likes, only: [:create, :destroy]
      end
    end
  end
end

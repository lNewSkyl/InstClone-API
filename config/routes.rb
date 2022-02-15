Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :users, param: :_username
      post '/auth/login', to: 'authentication#login'
      resources :posts do        
        resources :likes
      end
    end
  end
  root 'api/v1/posts#index'
  get 'api/v1/', to: redirect('.')
end

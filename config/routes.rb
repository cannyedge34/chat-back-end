Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  
  scope module: :v2, constraints: ApiVersion.new('v2') do
    resources :rooms, only: :index
  end

  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :rooms do
      resources :messages
    end
    # Serve websocket cable requests in-process
    mount ActionCable.server => '/cable'
  end

end

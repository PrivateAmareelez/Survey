Rails.application.routes.draw do
  devise_for :users
  resources :polls do
    resources :questions
    resources :replies, only: [:new, :create, :finish]
  end

  root 'secret_codes#show'

  get '/secret_codes/show', to: 'secret_codes#show'
  post '/secret_codes/check', to: 'secret_codes#check'
  post '/polls/run', to: 'polls#run'
  get '/polls/stop', to: 'polls#stop'
  get '/polls/:id/stop', to: 'polls#stop', as: 'stop_path'

  get '*path', to: 'secret_codes#show' unless Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

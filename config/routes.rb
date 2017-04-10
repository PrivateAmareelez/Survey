Rails.application.routes.draw do
  devise_for :users
  resources :polls do
    resources :questions
    resources :replies, only: [:new, :create, :finish]
  end

  root 'secret_codes#show'

  get '/secret_codes/show', to: 'secret_codes#show'
  post '/secret_codes/check', to: 'secret_codes#check'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

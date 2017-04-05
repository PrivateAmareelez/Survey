Rails.application.routes.draw do
  resources :polls do
    resources :questions
    resources :replies, only: [:new, :create]
  end

  root 'polls#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

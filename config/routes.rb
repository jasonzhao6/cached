TwitterClone::Application.routes.draw do

  root :to => 'tweets#index'
  get 'quote' => 'tweets#quote'
  resources :tweets do
    get :reply
  end

  get 'login' => 'sessions#login'
  post 'login' => 'sessions#actually_login'
  post 'sign_up' => 'sessions#sign_up'
  get 'logout' => 'sessions#logout'

end

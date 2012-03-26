EvernoteClone::Application.routes.draw do

  root :to => 'articles#index'
  resources :articles do
    # get :related TODO implement vector based document matching algorithm
  end

  get 'demo' => 'articles#index', defaults: {user_id: 2}

  get 'login' => 'sessions#login'
  post 'login' => 'sessions#actually_login'
  post 'sign_up' => 'sessions#sign_up'
  get 'logout' => 'sessions#logout'

end

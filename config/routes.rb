Cached::Application.routes.draw do

  root :to => 'articles#index'
  resources :articles do
    # get :related TODO implement vector based document matching algorithm
  end

  get 'search' => 'articles#search'

  get 'demo' => 'articles#index', defaults: {demo: true}

  get 'login' => 'sessions#login'
  post 'login' => 'sessions#actually_login'
  post 'sign_up' => 'sessions#sign_up'
  get 'logout' => 'sessions#logout'

end

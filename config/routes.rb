EvernoteClone::Application.routes.draw do

  root :to => 'articles#index'
  resources :articles do
    # get :related TODO implement vector based document matching algorithm
  end

  get 'users/:user_id' => 'articles#index' # for browsing other people's articles

  get 'login' => 'sessions#login'
  post 'login' => 'sessions#actually_login'
  post 'sign_up' => 'sessions#sign_up'
  get 'logout' => 'sessions#logout'

end

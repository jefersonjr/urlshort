Rails.application.routes.draw do

  # Users area
  devise_for :users

  # About page
  get :about, :to => 'index#about', :as => :about

  # Shortcut resource
  resources :shortcuts do
    member do
      get :redirect, :as => :redirect
    end
  end

  # Root path
  root 'index#index'

  # Redirect all unknown routes to try parse shortcut URL
  get '*path' => 'index#parse_shortcut'
end

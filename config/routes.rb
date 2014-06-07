Rails.application.routes.draw do
  resources :practices do
    member { get :statuses }
  end

  resources :skaters

  resources :skater_practices

  root 'dashboard#index'
  get 'dashboard/' => 'dashboard#index'

end

Rails.application.routes.draw do
  root 'reports#attendence_percentage'

  get '/login' => 'sessions#new', as: 'login'
  get '/logoff' => 'sessions#destroy', as: 'logoff'
  resources :sessions
  resources :users

  resources :practices do
    member { get :statuses }
  end

  resources :skaters do
    member { get :practices }
  end

  resources :skater_practices

  get 'dashboard/' => 'dashboard#index', as: 'management_dashboard'

  get 'reports/attendence_percentage' => 'reports#attendence_percentage',
    as: 'attendence_percentage_report'
end

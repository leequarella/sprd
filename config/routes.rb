Rails.application.routes.draw do
  resources :practices do
    member { get :statuses }
  end

  resources :skaters

  resources :skater_practices

  root 'dashboard#index'
  get 'dashboard/' => 'dashboard#index'

  get 'reports/attendence_percentage' => 'reports#attendence_percentage',
    as: 'attendence_percentage_report'
end

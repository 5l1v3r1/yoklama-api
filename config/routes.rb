Rails.application.routes.draw do
  resources :students
  resources :inspections
  post 'inspections/list', to: 'inspections#list'
  resources :lessons, only: [:index]
end

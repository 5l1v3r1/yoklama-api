Rails.application.routes.draw do
  resources :students
  resources :inspections
  resources :lessons, only: [:index]
end

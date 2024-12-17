Rails.application.routes.draw do
  root 'home#index'
  
  get 'concept', to: 'concept#index'
  get 'certification', to: 'certification#index'
  get 'education', to: 'education#index'
  get 'cases', to: 'cases#index'
  get 'contact', to: 'contact#index'
end
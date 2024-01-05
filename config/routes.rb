Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  resources :main, only: %i[index]
  root to: 'main#index'
end

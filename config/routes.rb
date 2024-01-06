Rails.application.routes.draw do
  resources :main, only: %i[index]
  root to: 'main#index'

  get '/search', to: 'main#search', as: :search
end

Rails.application.routes.draw do
  root 'voices#index'

  resources :voices
end

Rails.application.routes.draw do
  root 'voices#index'

  resources :voices

  post 'timed_text', to: 'youtube#timed_text'

end

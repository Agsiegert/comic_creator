
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :comics
      resources :panels
    end
  end

  root to: 'react#show'
  get '*path', to: 'react#show', constraints: { format: 'html' }
end

Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :courses, only:  %i[index show create]
    end
  end
end

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  namespace :users do
    resource :report, only: [:show]
  end

  namespace :admin do
    resources :users do
      resources :work_days
      resource :report
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

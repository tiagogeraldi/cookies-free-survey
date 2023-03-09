Rails.application.routes.draw do
  namespace :quizer do
    resources :quizzes, param: :owner_secret do
      collection do
        get :results
      end

      resources :questions, except: :show do
        resources :alternatives, except: :show
      end
    end

    resources :answers, only: %i(index new create update)
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "quizer/quizzes#index"
end

Rails.application.routes.draw do
  namespace :quizer do
    resources :quizzes
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "quizer/quizzes#index"
end

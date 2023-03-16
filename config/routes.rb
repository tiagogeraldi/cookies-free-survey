Rails.application.routes.draw do
  namespace :quizer do
    resources :quizzes, param: :owner_secret do
      member do
        post :clone
      end

      resources :questions, except: :show do
        member do
          put :move_up
          put :move_down
          put :move_top
          put :move_bottom
        end

        resources :alternatives, except: :show
      end

      resources :results, only: %i(index show) do
        collection do
          get :logs
          delete :delete_all
        end
      end

      resources :exports, only: %i(index show)
    end

    resources :answers, only: %i(index new) do
      collection do
        post :upsert
        get :done
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "quizer/quizzes#index"
end

Rails.application.routes.draw do
  resources :contacts, only: %i(new create index)

  mount RailsAdmin::Engine => '/admss', as: 'rails_admin'

  namespace :quizer, path: 'q' do
    resources :quizzes, path: 'q', param: :owner_secret do
      member do
        post :clone
        patch :toggle_active
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

    resources :answers, path: 'a', only: %i(index new) do
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

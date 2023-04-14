Rails.application.routes.draw do
  get 'payments/index'
  resources :contacts, only: %i(new create index)

  mount RailsAdmin::Engine => '/admss', as: 'rails_admin'

  namespace :quizer, path: 'q' do
    resources :quizzes, except: :create, path: 'q', param: :owner_secret do
      collection do
        get :help
      end
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
      resources :payments, only: %i(index create) do
        collection do
          post :approve
        end
      end
    end

    resources :answers, path: 'a', only: %i(index new) do
      collection do
        post :upsert
        get :done
      end
    end
  end

  # Defines the root path route ("/")
  root "quizer/quizzes#index"
end

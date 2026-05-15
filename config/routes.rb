Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  scope "/d" do
    root to: "dashboards#show", as: :d_root

    resources :klasses, path: "classes"

    resources :courses do
      shallow do
        resources :klasses, path: "classes" do
          resources :contents, shallow: false
          resources :announcements, shallow: false
          resources :grades, only: %i[ index ]
          resources :students, shallow: false, except: %i[ edit update ]
          resources :teachers, shallow: false, except: %i[ edit update ]

          resources :submissions, shallow: false, except: %i[index new create] do
            member do
              get :grade
              patch :grade
            end
          end

          resources :assignments, shallow: false do
            resources :submissions, only: %i[index new create]
          end
        end
      end
    end
  end

  # Defines the root path route ("/")
  root "dashboards#show"
end

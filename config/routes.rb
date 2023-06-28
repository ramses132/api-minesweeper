# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :players, only: [] do
        collection do
          post :find_or_create
          get :hello
        end
        member do
          get :show
        end
      end

      resources :games, only: %i[create show index] do
        member do
          patch :flag
          patch :question
          patch :reveal
          get :generate_text
        end
      end
    end
  end
end

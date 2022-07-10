Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :passing_instance do
      resources :apples, only: :create
    end

    namespace :passing_open_struct do
      resources :apples, only: :create
    end

    namespace :instance_method do
      resources :apples, only: :create
    end

    namespace :queue_name do
      resources :default_queues, only: :create
      resources :custom_queues, only: :create
      resources :another_queues, only: :create
    end

    namespace :parent_child do
      resources :starkings, only: :create
      resources :low_priorities, only: :create
    end

    namespace :rollback do
      resources :apples, only: :create
    end

    namespace :always_fail_jobs do
      resources :apples, only: :create
    end

    namespace :priority do
      resources :low_priorities, only: :create
      resources :high_priorities, only: :create
    end

    namespace :email do
      resources :only_emails, only: :create
      resources :deliver_options, only: :create
      resources :transactions, only: :create
    end

    namespace :queue_backend do
      resources :async_backends, only: :create
    end
  end
end

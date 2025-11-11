Rails.application.routes.draw do
  resource :profile, only: [:show, :edit, :update]
  get "dashboard/index"
  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :posts
  get "home/index"
  get "dashboard", to: "dashboard#index", as: :dashboard
  get '/by/:user_name/project/:slug', to: 'posts#show_by_slug', as: :user_project, constraints: { user_name: /[^\/]+/ }
  get "/explore", to: "posts#explore", as: :explore

  # Custom settings pages for editing email and password
  devise_scope :user do
    get   'users/edit_name' ,      to: 'users/registrations#edit_name',       as: :edit_user_name
    patch 'users/update_name',     to: 'users/registrations#update_name',     as: :update_user_name
    get   'users/edit_email',      to: 'users/registrations#edit_email',      as: :edit_user_email
    patch 'users/update_email',    to: 'users/registrations#update_email',    as: :update_user_email
    get   'users/edit_password',   to: 'users/registrations#edit_password',   as: :edit_user_password_custom
    patch 'users/update_password', to: 'users/registrations#update_password', as: :update_user_password
  end

   # Account settings page
  get 'users/edit', to: 'users/registrations#edit', as: :settings

  # Health check and root path
  get "up" => "rails/health#show", as: :rails_health_check

  get "/:user_name", to: "profiles#show", as: :profile_by_username,
    constraints: { user_name: /[^\/]+/ }

  root "home#index"
end


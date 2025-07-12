Rails.application.routes.draw do
  root "projects#index"
  devise_for :users

  resources :projects, only: [:index]
  resources :allocations, only: [:new, :create, :show]
  get "admin/report", to: "admin#report", as: :admin_report

  # For home and logout
  get "home", to: "projects#index", as: :home
end

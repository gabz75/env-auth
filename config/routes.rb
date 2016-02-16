Rails.application.routes.draw do
  devise_for :logins
  namespace :v1 do
    resource :logins, only: [:show, :create, :destroy]
    resource :sessions, only: [:show, :create, :destroy]
  end
end

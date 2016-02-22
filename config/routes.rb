Rails.application.routes.draw do
  namespace :v1 do
    resource :accounts, only: [:show, :create, :destroy]
    resource :tokens, only: [:create]
  end
end

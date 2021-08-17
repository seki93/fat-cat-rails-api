Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :users, only: [:show, :create, :update, :destroy]
    end
  end
end

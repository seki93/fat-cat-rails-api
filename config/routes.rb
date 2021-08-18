Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :users, only: [:show, :create, :update, :destroy]
      resource :time_tracks, only: [:show, :create, :update] do
        collection do
          get 'daily_report'
          get 'weekly_report'
          get 'report'
        end
      end
    end
  end
end

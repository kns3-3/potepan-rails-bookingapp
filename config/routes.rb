Rails.application.routes.draw do
  
  root "home#top"

  devise_for :users

  resources :users, only: [:show, :edit, :update]

  #あいまい検索
  resources :rooms do
    collection do
      get "search"
    end
  end

  #予約関連
  resources :reservations, only: [:index, :create] do
    collection do
      post :confirm #予約確認画面用
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end

Rails.application.routes.draw do
  devise_for :user, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


  scope module: :user do
    root :to => "homes#top"
    get "search" => "searches#search"
    get "/users/:id/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
    patch "/users/:id/withdrawal" => "users#withdrawal", as: "withdrawal"
    resources :posts do
      resources :post_comments, only: [:create,:destroy]
      resource :favorites, only: [:create,:destroy]
    end
    resources :users, only: [:index,:show,:edit,:update] do
      member do
        get :favorites
      end
    end
    resources :tags do
      get 'posts', to: 'posts#search'
    end
  end


  namespace :admin do
    resources :posts
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

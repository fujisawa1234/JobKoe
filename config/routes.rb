Rails.application.routes.draw do
  devise_for :user, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  
  scope module: :user do
    root :to => "posts#index"
    get "search" => "searches#search"
    resources :posts
    resources :users, only: [:show,:edit,:update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

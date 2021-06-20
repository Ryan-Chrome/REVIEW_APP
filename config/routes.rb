Rails.application.routes.draw do
  root "pages#home"
  get "/follow", to: "users#follow", as: "follow"
  resources :admins, only: [:index]
  resources :reviews, only: [:show, :index, :new, :create, :edit, :update, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :review_relationships, only: [:create, :destroy]
  resources :users, only: [:show]
  devise_for :users, :controllers => {
                       :registrations => "users/registrations",
                     }

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

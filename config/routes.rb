Rails.application.routes.draw do
  root 'pages#home'
  get '/show/:id', to: 'pages#show', as: 'show'
  get '/follow', to: 'pages#follow', as: 'follow'
  resources :reviews, only:[:show, :index, :new, :create, :edit, :update, :destroy]
  resources :relationships, only:[:create, :destroy]
  resources :review_relationships, only:[:create, :destroy]
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

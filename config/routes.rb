Rails.application.routes.draw do
  devise_for :users
  root to: "books#index"

  resources :notes
  resources :books
  resources :export_note, only: [:create]
  resources :export_book, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

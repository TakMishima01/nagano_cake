Rails.application.routes.draw do

root to: "public/homes#top"
get '/about' => "public/homes#about", as: 'about'

 devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


scope module: :public do
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdraw]
  end

namespace :admin do
  root 'homes#top'
  resources :genres, only: [:index, :create, :edit, :update]
  resources :items, except: [:destroy]
end



 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do

devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


root to: "public/homes#top"
get '/about' => "public/homes#about", as: 'about'

scope module: :public do
    resources :items, only: [:index, :show]

    get "/customers/unsubscribe" => "customers#unsubscribe", as: 'unsubscribe'
    patch "/customers/withdraw" => 'customers#withdraw', as: 'withdraw'
    get "/customers/mypage" => "customers#show"
    get "/customers/information/edit" => "customers#edit"
    patch "/customers/information" => "customers#update"

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]

    post "/orders/confirm" => 'orders#confirm'
    get "/orders/complete" => 'orders#complete'
    resources :orders, only: [:new, :create, :index, :show]

    delete "/cart_items/destroy_all" => 'cart_items#destroy_all', as: 'destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]


  end

namespace :admin do
  resources :genres, only: [:index, :create, :edit, :update]
  resources :items, except: [:destroy]
  get "customers/:id/order_list" => "customers#order_list", as: "order_list"
  resources :customers, only: [:index, :show, :edit, :update]
  root 'orders#index'
  resources :orders, only: [:index, :show, :update]
  resources :order_details, only: [:update]
end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

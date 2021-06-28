Rails.application.routes.draw do
  root to: 'home#index'
  
  scope '/:locale' do
    root to: 'home#index'

    get 'home/index'

    get 'home/about'

    resources :sessions, only: [:new, :create, :destroy]

    resources :users, only: [:index, :show, :new, :create]

    resources :invitations, only: [:create, :update, :destroy]

    resources :checkins, only: [:new, :create, :edit, :update, :destroy]

    resources :conversations do
      resources :messages
    end

    get 'signup', to: 'users#new'
    get 'login', to: 'sessions#new'

    get 'account/edit'
    patch 'account', to: 'account#update'
    get 'account/home'
    get 'account', to: 'account#home'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  get 'users/update'

  get 'leads/index'

  get 'leads/create'

  get 'leads/update'

  get 'leads/destroy'

  get 'profile', to: 'profile#edit'
  resources :users, only: :update
  resources :user_tools, only: :update

  resources :companies, only: [:index, :show]

  resources :leads, only: [:index, :create, :update, :destroy]

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  # get 'user_techs/create'

  # get 'users/update'

  # get 'leads/index'

  # get 'leads/update'

  # get 'leads/destroy'

  # get 'leads/create'

  # get 'companies/index'

  # get 'companies/show'

  get 'profile', to: 'profile#edit'
  resources :users, only: :update
  resources :user_tools, only: :update

  resources :companies, only: [:index, :show]

  resources :leads, only: [:index, :create, :update, :destroy]

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

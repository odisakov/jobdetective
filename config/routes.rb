Rails.application.routes.draw do
  get 'leads/index'

  get 'leads/update'

  get 'leads/destroy'

  get 'leads/create'

  get 'companies/index'

  get 'companies/show'

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

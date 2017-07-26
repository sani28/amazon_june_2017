Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get('/', {to: 'welcome#index', as: 'home'})
  get('/about', {to: 'welcome#about'})

  get('/contact', {to: 'contact#new'})
  post('/contact', {to: 'contact#create'})

  resources :products do
    resources :reviews
  end

  resources :users, only: [:new, :create]
  resources :tags

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  # This is the same as above
  # resource :sessions, only: [:new, :create, :destroy]

  namespace :admin do
    resources :dashboard, only: [:index]
  end
end

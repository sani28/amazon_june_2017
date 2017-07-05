Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get('/', {to: 'welcome#index', as: 'home'})
  get('/about', {to: 'welcome#about'})
  get('/contact', {to: 'contact#new'})
  post('/contact', {to: 'contact#create'})
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only:[:index,:create,:show] do
    resources :projects, only:[:new,:index,:show,:create,:edit]
  end
  resources :projects, only:[:new,:index,:show,:create,:edit]

  resources :tasks, only:[:new,:index,:show,:create,:edit]
  get '/signup', to:'users#new', as: 'signup'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/homepage', to: 'users#show'
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/signup', to:'users#new', as: 'signup'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/homepage', to: 'users#show'
  resources :users, only:[:index,:create,:show] do
    resources :projects, only:[:index,:new,:show,:create,:edit]
    end

    resources :projects, only:[:index,:new,:show,:create,:edit] do
      resources :sections, only:[:index,:new,:create,:show,:edit]
    end

    resources :sections, only:[:index,:new,:create,:show,:edit]

resources :projects, only:[:index,:new,:show,:create,:edit] do
  resources :tasks, only:[:index,:new,:create,:show,:edit]
end
resources :tasks

end

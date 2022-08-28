Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/signup', to:'users#new', as: 'signup'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/auth/github/callback' => 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  get '/homepage', to: 'users#show'

  resources :users, only:[:index,:create,:show] do
    resources :projects, only:[:index,:new,:show,:create,:edit]
    end

    delete'/projects/:project_id', to: 'projects#destroy', as: 'delete_project'

    resources :projects, only:[:index,:new,:show,:create,:edit] do
      resources :sections, only:[:index,:new,:create,:show,:edit]
    end
    delete'/projects/:project_id/sections/:id', to: 'sections#destroy', as: 'delete_section'

    resources :sections, only:[:index,:new,:create,:show,:edit]

resources :projects, only:[:index,:new,:show,:create,:edit] do
  resources :tasks, only:[:index,:new,:create,:show,:edit]
end
resources :tasks, only:[:index,:new,:create,:show,:edit,:update]
delete'/tasks/:id', to: 'tasks#destroy', as: 'delete_task'

end

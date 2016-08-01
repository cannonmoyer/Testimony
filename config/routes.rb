Rails.application.routes.draw do
  
  devise_for :users
  root 'static_pages#home'
  get 'home', to: 'static_pages#home', as: 'home'

  match "/stories/search" => "stories#search", via: :get
  get 'stories/:id/view', to: 'stories#view', as: 'view_story'
  get 'stories/awaiting_approval', to: 'stories#awaiting_approval', as: 'view_awaiting_approval'
  resources :stories
  #get 'stories/new', to:'stories#new', as: 'stories'

end

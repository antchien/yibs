NewAuthDemo::Application.routes.draw do
  resources :users, :only => [:create, :new, :show, :update, :edit, :index] do
    member do
      get 'notifications'
      get 'refresh'
    end
    resources :friendships, :only => [:index, :create, :update, :destroy] do
      collection do
        get 'search_friends'
        get 'search'
        post 'invite'
      end
    end
    resources :bets, :only => [:create, :new, :index]
    resources :bet_participations, :only => [:update, :destroy]
  end
  resource :session, :only => [:create, :destroy, :new]
  resources :bets, :only => [:show, :edit, :update] do
    resources :comments, only: [:create, :new, :show]
    get 'community', on: :collection
    get 'pending', on: :collection
    get 'inplay', on: :collection
    get 'completed', on: :collection
  end
  get '/auth/:provider/callback', to: 'sessions#create'
  root :to => 'users#index'
end

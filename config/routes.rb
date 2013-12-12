NewAuthDemo::Application.routes.draw do
  resources :users, :only => [:create, :new, :show, :update, :edit] do
    resources :friendships, :only => [:index, :create, :update, :destroy]
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
  root :to => "users#show"
end

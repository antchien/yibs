NewAuthDemo::Application.routes.draw do
  resources :users, :only => [:create, :new, :show, :update, :edit] do
    resources :friendships, :only => [:index, :create, :update, :destroy]
    resources :bets, :only => [:create, :new, :index]
  end
  resource :session, :only => [:create, :destroy, :new]
  resources :bets, :only => [:show, :edit, :update]
  root :to => "users#show"
end

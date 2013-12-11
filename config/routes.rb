NewAuthDemo::Application.routes.draw do
  resources :users, :only => [:create, :new, :show, :update, :edit] do
    resources :friendships, :only => [:index, :create, :update, :destroy]
  end
  resource :session, :only => [:create, :destroy, :new]

  root :to => "users#show"
end

class SessionsController < ApplicationController
  before_filter :require_no_current_user!, :only => [:create, :new]
  before_filter :require_current_user!, :only => [:destroy]

  def create
    if auth_hash
      #check to see if user acct has been created.  if not, create one, then login with auth_hash.
    else
      user = User.find_by_credentials(
        params[:user][:username],
        params[:user][:password]
      )
    end

    if user.nil?
      render :json => "Credentials were wrong"
    else
      self.current_user = user
      redirect_to root_url
    end
  end

  def destroy
    logout_current_user!
    redirect_to new_session_url
  end

  def new
  end
  
  private
  
  def auth_hash
    request.env['omniauth.auth']
  end
  
end

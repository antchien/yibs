class SessionsController < ApplicationController
  before_filter :require_no_current_user!, :only => [:create, :new]
  before_filter :require_current_user!, :only => [:destroy]

  def create
    if auth_hash
      #check to see if user acct has been created.  if not, create one, then login with auth_hash.
      case auth_hash[:provider]
      when "facebook"
        user = User.find_by_provider_and_uid(auth_hash[:provider],auth_hash[:uid])
        unless user
          #with the current set up, there will be a conflict if the user tries to log in with separate providers linked to the same email, since it will try to create another yibs acct w/ same email addr
          user = User.find_by_username(auth_hash[:info][:email])
          if user
            user.update_attributes(provider: auth_hash[:provider], uid: auth_hash[:uid])
          else
            user = User.create!(provider: auth_hash[:provider], uid: auth_hash[:uid], username: auth_hash[:info][:email], first_name: auth_hash[:info][:first_name], last_name: auth_hash[:info][:last_name], profile_pic: auth_hash[:info][:image])
          end
        end

      else
        flash.now[:error] = "Sorry, this provider is not supported yet."
      end
    else
      user = User.find_by_credentials(
        params[:user][:username],
        params[:user][:password]
      )
    end

    if user.nil?
      flash.now[:error] ||= "Uh oh, Invalid Email/Password!  Please try again."
      render :new
    else
      if user.username == "marshmallow@fakemail.com"
        flash[:notice] = "This is a demo account.  Feel free to make comments, add bets, etc as changes will be reset regularly.  ENJOY!"
      end
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

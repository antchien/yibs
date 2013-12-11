module SessionsHelper
  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def current_user=(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def logout_current_user!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_current_user!
    render :json => "Error: Requires login", status: 422 if current_user.nil?
  end

  def require_no_current_user!
    render :json => "Error: Expected new user", status: 422 unless current_user.nil?
  end

  def require_admin_access!
    if params[:user_id]
      render :json => "Error: Requires admin access", status: 422 if params[:user_id].to_i != current_user.id
    elsif params[:id]
      render :json => "Error: Requires admin access", status: 422 if params[:id].to_i != current_user.id
    end
  end

end

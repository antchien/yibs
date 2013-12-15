class UsersController < ApplicationController
  before_filter :require_current_user!, :only => [:show, :edit, :update]
  before_filter :require_no_current_user!, :only => [:create, :new]
  before_filter :require_admin_access!, :only => [:edit, :update]

  def create
    @user = User.new(params[:user])

    if @user.save
      self.current_user = @user
      redirect_to root_url
    else
      render :json => @user.errors.full_messages
    end
  end

  def new
    @user = User.new
  end

  def show
    if params.include?(:id)
      @user = User.find(params[:id])
      @bets = @user.bets.select { |bet| !@user.inbound_pending_bets.include?(bet) }
      @inbound_pending_bets = @user.inbound_pending_bets
    else
      redirect_to user_url(current_user)
    end
  end

  def edit
    if params.include?(:id)
      @user = User.find(params[:id])
    else
      redirect_to user_url(current_user)
    end
  end

  def update
    if current_user.id == params[:id].to_i
      @user = current_user
      @user.update_attributes(params[:user])
      if @user.save
        redirect_to root_url
      else
        render :json => @user.errors.full_messages
      end
    else
      redirect_to edit_user_url(current_user)
    end
  end

  def notifications
    @user = current_user
    @notifications = @user.notifications
    render :notifications
  end

end

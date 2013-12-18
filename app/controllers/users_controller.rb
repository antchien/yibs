class UsersController < ApplicationController
  before_filter :require_current_user!, :only => [:show, :edit, :update, :index]
  before_filter :require_no_current_user!, :only => [:create, :new]
  before_filter :require_admin_access!, :only => [:edit, :update]

  def create
    @user = User.find_by_username(params[:user][:username])
    if @user && !@user.password_digest && !@user.provider
      if @user.update_attributes(params[:user])
        self.current_user = @user
        redirect_to root_url
      else
        render :json => @user.errors.full_messages
      end
    else
      @user = User.new(params[:user])
      if @user.save
        self.current_user = @user
        redirect_to root_url
      else
        render :json => @user.errors.full_messages
      end
    end
  end

  def new
    @user = User.new
  end

  def show
    if params.include?(:id)
      @user = User.find(params[:id])
      if @user == current_user
        @bets = @user.bets
      else
        @bets = @user.bets.where(private: false)
      end
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

  def index
    @user = current_user
    @notifications = @user.notifications
    @community_bets = @user.community_bets
    @pending_bets = @user.pending_bets
    @inplay_bets = @user.inplay_bets
    @completed_bets = @user.completed_bets
    @user_bet_count = @user.bets.count
    @user_inplay_count = @user.inplay_bets.count
    @user_win_count = @user.bets_won.count
  end

  def notifications
    @user = current_user
    @notifications = @user.notifications
    render :notifications
  end

  def refresh
    #can be optimized to utilize only 1 or 2 passes into the database rather than 4-5
    @user = current_user
    @notifications = @user.notifications
    @community_bets = @user.community_bets
    @pending_bets = @user.pending_bets
    @inplay_bets = @user.in_play_bets
    @completed_bets = @user.completed_bets
  end



end

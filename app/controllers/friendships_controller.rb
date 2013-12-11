class FriendshipsController < ApplicationController
    before_filter :require_admin_access!, :only => [:create, :destroy]

  def index
    @users = User.all
    @friends = current_user.friends
    @outbound_pending_friends = current_user.outbound_pending_friends
    @inbound_pending_friends = current_user.inbound_pending_friends
  end

  def create
    @friendship = Friendship.new(params[:friendship])
    @friendship.out_friend_id = current_user.id
    if @friendship.save
      redirect_to user_friendships_url(current_user)
    else
      render :json => "Can not save friendship"
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship
      @friendship.find_recip_friendship.destroy
      @friendship.destroy
      redirect_to user_friendships_url(current_user)
    else
      render :json => "Can not find friendship"
    end
  end

end

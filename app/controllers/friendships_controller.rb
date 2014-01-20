class FriendshipsController < ApplicationController
    before_filter :require_admin_access!, :only => [:create, :destroy]

  def index
    @users = current_user.friends
    @users += current_user.outbound_pending_friends
    @users += current_user.inbound_pending_friends
    if request.xhr?
      render partial: 'friendships/show_details_lightbox', locals: {users: @users}
    else
      render partial: 'friendships/show_details_lightbox', locals: {users: @users}
    end
  end

  def search
    @user = current_user
    @users = User.search_by_name_and_email(params[:query])
    if request.xhr?
      render partial: 'friendships/show_details_lightbox', locals: {users: @users}
    else
      render partial: 'friendships/show_details_lightbox', locals: {users: @users}
    end
  end

  def create
    @friendship = Friendship.new(params[:friendship])
    @friendship.out_friend_id = current_user.id
    if @friendship.save
      check_recip_friendship_and_send_notifications(@friendship)
      if request.xhr?
        render partial: 'friendships/friendship_detail', locals: {user: @friendship.in_friend}
      else
        redirect_to user_friendships_url(current_user)
      end

    else
      render :json => "Can not save friendship"
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship
      @other_user = @friendship.in_friend
      @friendship.find_recip_friendship.destroy
      @friendship.destroy
      if request.xhr?
        render partial: 'friendships/friendship_detail', locals: {user: @other_user}
      else
        redirect_to user_friendships_url(current_user)
      end
    else
      render :json => "Can not find friendship"
    end
  end

  def find

  end

  def search_friends
    @user = current_user
    @users = current_user.friends.search_by_name_and_email(params[:query])
    if request.xhr?
      render partial: 'friendships/drop_down_list', locals: {users: @users}
    else
      render partial: 'friendships/drop_down_list', locals: {users: @users}
    end
  end
  
  def pendings
    @pendings = current_user.inbound_pending_friends
    if request.xhr?
      render partial: 'friendships/show_details_lightbox', locals: {users: @pendings}
    else
      render partial: 'friendships/show_details_lightbox', locals: {users: @pendings}
    end
  end


  def invite
    new_user = User.find_by_username(params[:email])
    if new_user
      flash[:error] = "User already exists"
      redirect_to user_friendships_url(current_user)
    else
      new_user = User.new(username: params[:email])
      invite_email = UserMailer.invite_email(new_user, current_user)
      if invite_email.deliver
        flash[:notice] = "Invitation sent!"
      else
        flash[:error] = "Error in sending invitation email"
      end
    end

    redirect_to user_friendships_url(current_user)
  end

  def check_recip_friendship_and_send_notifications(friendship)
    recip_friendship = friendship.find_recip_friendship
    if recip_friendship && recip_friendship.pending_flag
      Notification.create(user_id: friendship.in_friend.id, text: "#{friendship.out_friend.first_name} #{friendship.out_friend.last_name} accepted your friend request!", link: user_url(friendship.out_friend))
      friendship.update_attribute(:pending_flag, false)
      recip_friendship.update_attribute(:pending_flag, false)
    else
      Notification.create(user_id: friendship.in_friend.id, text: "#{friendship.out_friend.first_name} #{friendship.out_friend.last_name} sent you a friend request!", link: pendings_user_friendships_url(friendship.in_friend))
    end
  end

end

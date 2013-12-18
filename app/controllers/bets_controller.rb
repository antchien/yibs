class BetsController < ApplicationController
  before_filter :require_current_user!, :only => [:community, :pending, :inplay, :completed]
  before_filter :require_admin_access!, :only => [:create, :new, :index]
  before_filter :require_bet_participant!, :only => [:edit, :update]

  def create
    @bet = Bet.new(params[:bet])
    @bet.user_id = current_user.id
    if @bet.save
      new_user_emails = parse_new_users(params[:new_user_emails])
      new_user_emails.each do |new_user_email|
        user = User.find_by_username(new_user_email)
        if user
          params[:bet_participation][:user_id] << user.id
        else
          new_user = User.create(username: new_user_email)
          invite_email = UserMailer.invite_challenge_email(new_user, current_user)
          invite_email.deliver!
          params[:bet_participation][:user_id] << new_user.id
        end
      end
      BetParticipation.create(bet_id: @bet.id, user_id: current_user.id, status: "accepted")
      params[:bet_participation][:user_id].each do |participant_id|
        next if participant_id == ""
        BetParticipation.create(bet_id: @bet.id, user_id: participant_id.to_i, status: "pending")
        Notification.create(user_id: participant_id.to_i, text: "#{@bet.author.abbrev_name}. has challenged you to a bet!", link: bet_url(@bet))
      end
    else
      render :json => "Unable to save bet"
    end

    redirect_to bet_url(@bet)
  end

  def new
    @bet = Bet.new
  end

  def index
  end

  def show
    @bets = []
    @bets << Bet.find(params[:id])
    require_bet_participant! if @bets.first.private

    @user = current_user
    render '/users/index'

  end

  def edit
    @bet = Bet.find(params[:id])
  end

  #need its own permission check, sicne there is no user_id
  def update
    participant_ids = params[:bet_participation][:user_id]
    winner_ids = params[:bet_winner][:user_id]
    loser_ids = params[:bet_loser][:user_id]

    @bet = Bet.find(params[:id])
    if @bet.update_attributes( params[:bet] )
      @bet.update_attributes( private: false ) if !params[:bet][:private]
      #first destroy any old participants that isn't in the new set
      update_participants(@bet, participant_ids)
      update_winners(@bet, winner_ids)
      update_losers(@bet, loser_ids)
    else
      flash[:error] = "Unable to update bet"
    end
    redirect_to bet_url(@bet)
  end


  def community
    @user = current_user
    @bets = current_user.bets.where( status: 'in play' )
    @user.friends.each do |friend|
      @bets.concat( friend.bets.where(status:'in play').select { |bet| !@bets.include?(bet) && !bet.private } )
    end
    @bets.sort_by { |bet| Time.now()-bet.updated_at }

    if request.xhr?
      render partial: 'bets/display_bets', locals: {bets: @bets}
    else
      render :feed
    end
  end

  def pending
    @user = current_user
    @bets = current_user.bets.where( status: 'pending' )
    @bets.sort_by { |bet| Time.now()-bet.updated_at }
    if request.xhr?
      render partial: 'bets/display_bets', locals: {bets: @bets}
    else
      render :feed
    end
  end

  def inplay
    @user = current_user
    @bets = current_user.bets.where( status: 'in play' )
    @bets.sort_by { |bet| Time.now()-bet.updated_at }
    if request.xhr?
      render partial: 'bets/display_bets', locals: {bets: @bets}
    else
      render :feed
    end
  end

  def completed
    @user = current_user
    @bets = current_user.bets.where( status: 'completed' )
    @bets.sort_by { |bet| Time.now()-bet.updated_at }
    if request.xhr?
      render partial: 'bets/display_bets', locals: {bets: @bets}
    else
      render :feed
    end
  end

  private

  def update_participants(bet, participant_ids)
    @bet = bet

    #first delete removed participants
    @bet.participants.each do |participant|
      if !participant_ids.include?(participant.id.to_s) && participant.id != @bet.author.id
        BetParticipation.find_by_bet_id_and_user_id(@bet.id, participant.id).destroy
        Notification.create(user_id: participant.id, text: "You have been removed from a bet", link: bet_url(@bet))
      end
    end
    #send change notifications to existing participants
    @bet.participants.each do |participant|
      unless participant == current_user
        Notification.create(user_id: participant.id, text: "#{current_user.abbrev_name}. has edited a bet that you're in", link: bet_url(@bet))
      end
    end

    #then make any more participations that aren't present in the database
    participant_ids.each do |new_participant_id|
      next if new_participant_id == ""
      if @bet.participants.select { |participant| participant.id == new_participant_id.to_i }.empty?
        BetParticipation.create(bet_id: @bet.id, user_id: new_participant_id.to_i, status: "pending")
        Notification.create(user_id: new_participant_id.to_i, text: "#{current_user.abbrev_name}. included you in a bet!", link: bet_url(@bet))
      end
    end
  end

  def update_losers(bet, loser_ids)
    @bet = bet
    loser_ids.each do |loser_id|
      next if loser_id == ""
      LoserEntry.create(user_id: loser_id.to_i, bet_id: @bet.id)
      Notification.create(user_id: loser_id.to_i, text: 'You lost a bet!', link: bet_url(@bet) )
    end
  end

  def update_winners(bet, winner_ids)
    @bet = bet
    winner_ids.each do |winner_id|
      next if winner_id == ""
      WinnerEntry.create(user_id: winner_id.to_i, bet_id: @bet.id)
      Notification.create(user_id: winner_id.to_i, text: 'You lost a bet!', link: bet_url(@bet) )
    end
  end

  def parse_new_users(users_string)
    return users_string.split(",").map(&:strip)
  end

  def require_bet_participant!
    @bet = Bet.find(params[:id])
    unless @bet.participants.include?(current_user)
      flash[:error] = "You do not have permission for this action"
      if @bet.private
        redirect_to root_url
      else
        redirect_to bet_url(@bet)
      end
    end
  end

end

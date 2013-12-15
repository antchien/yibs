class BetsController < ApplicationController
  before_filter :require_current_user!, :only => [:community, :pending, :inplay, :completed]
  before_filter :require_admin_access!, :only => [:create, :new, :index]

  def create
    @bet = Bet.new(params[:bet])
    @bet.user_id = current_user.id
    if @bet.save
      BetParticipation.create(bet_id: @bet.id, user_id: current_user.id, status: "accepted")
      params[:bet_participation][:user_id].each do |participant_id|
        BetParticipation.create(bet_id: @bet.id, user_id: participant_id.to_i, status: "pending")
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
    @bet = Bet.find(params[:id])
    @user = current_user
  end

  def edit
    @bet = Bet.find(params[:id])
  end

  #need its own permission check, sicne there is no user_id
  def update
    participant_ids = params[:bet_participation][:user_id]
    @bet = Bet.find(params[:id])
    if @bet.update_attributes( params[:bet] )
      @bet.update_attributes( private: false ) if !params[:bet][:private]
      #first destroy any old participants that isn't in the new set
      @bet.participants.each do |participant|
        if !participant_ids.include?(participant.id.to_s) && participant.id != @bet.author.id
          BetParticipation.find_by_bet_id_and_user_id(@bet.id, participant.id).destroy
        end
      end
      #then make any more participations that aren't present in the database
      participant_ids.each do |new_participant_id|
        next if new_participant_id == ""
        if @bet.participants.select { |participant| participant.id == new_participant_id.to_i }.empty?
          BetParticipation.create(bet_id: @bet.id, user_id: new_participant_id.to_i, status: "pending")
        end
      end
    else
      render :json => "Unable to update bet"
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
    render :json => :feed
  end

  def pending
    @user = current_user
    @bets = current_user.bets.where( status: 'pending' )
    @bets.sort_by { |bet| Time.now()-bet.updated_at }
    render :feed
  end

  def inplay
    @user = current_user
    @bets = current_user.bets.where( status: 'in play' )
    @bets.sort_by { |bet| Time.now()-bet.updated_at }
    render :feed
  end

  def completed
    @user = current_user
    @bets = current_user.bets.where( status: 'completed' )
    @bets.sort_by { |bet| Time.now()-bet.updated_at }
    render :feed
  end

end

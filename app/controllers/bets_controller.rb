class BetsController < ApplicationController
  before_filter :require_current_user!, :only => [:community, :pending, :inplay, :completed]
  before_filter :require_admin_access!, :only => [:create, :new, :index]

  def create
    @bet = Bet.new(params[:bet])
    @bet.user_id = current_user.id
    @bet.save
    BetParticipation.create(bet_id: @bet.id, user_id: current_user.id, status: "accepted")
    params[:bet_participation][:user_id].each do |participant_id|
      BetParticipation.create(bet_id: @bet.id, user_id: participant_id.to_i, status: "pending")
    end

    redirect_to user_url(current_user)
  end

  def new
    @bet = Bet.new
  end

  def index
  end

  def show
    @bet = Bet.find(params[:id])
  end

  def edit
  end

  #need its own permission check, sicne there is no user_id
  def update
  end


  def community
    @user = current_user
    @bets = current_user.bets
    @user.friends.each do |friend|
      @bets.concat( friend.bets.select { |bet| !@bets.include?(bet) } )
    end

    @bets.sort_by { |bet| Time.now()-bet.updated_at }
    render :feed
  end


end

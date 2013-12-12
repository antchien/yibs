class BetParticipationsController < ApplicationController

  def update
    @bet_participation = BetParticipation.find(params[:id])
    @bet_participation.update_attributes(params[:bet_participation])
    @bet_participation.save
    if @bet_participation.bet.all_participants_accepted?
      @bet_participation.bet.update_attributes(status: "in play")
    elsif params[:bet_participation][:status] == "declined"
      @bet_participation.bet.update_attributes(status: "cancelled")
    end
    @bet_participation.bet.save


    redirect_to user_url(current_user)
  end

  def destroy
    @bet_participation = BetParticipation.find(params[:id]).destroy
    redirect_to user_url(current_user)
  end

end

class BetParticipationsController < ApplicationController

  def update
    @bet_participation = BetParticipation.find(params[:id])
    @bet_participation.update_attributes(params[:bet_participation])
    @bet_participation.save
    if @bet_participation.bet.all_participants_accepted?
      @bet_participation.bet.update_attributes(status: "in play")
      @bet_participation.bet.participants.each do |participant|
        Notification.create(user_id: participant.id, text: "One of your bets is now in play!", link: bet_url(@bet_participation.bet))
      end
    elsif params[:bet_participation][:status] == "declined"
      @bet_participation.bet.update_attributes(status: "cancelled")
      @bet_participation.bet.participants.each do |participant|
        next if participant == current_user
        Notification.create(user_id: participant.id, text: "One of your bets has been cancelled", link: bet_url(@bet_participation.bet))
      end
    end
    @bet_participation.bet.save

    redirect_to bet_url(@bet_participation.bet)
  end

  def destroy
    @bet_participation = BetParticipation.find(params[:id]).destroy
    redirect_to bet_url(@bet_participation.bet)
  end

end

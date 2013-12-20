class CommentsController < ApplicationController

  def create
    puts "------------------"
    puts params
    @comment = Comment.new(params[:comment])
    @comment.bet_id = params[:bet_id]
    @comment.user_id = current_user.id
    if @comment.save
      @comment.bet.commenters.each do |commenter|

        next if @comment.author == commenter

        if @comment.bet.participants.include?(commenter)
          Notification.create(user_id: commenter.id, text: "#{@comment.author.abbrev_name}. also commented on a bet that you're in with #{@comment.bet.author.abbrev_name}.", link: bet_url(@comment.bet))
        else
          Notification.create(user_id: commenter.id, text: "#{@comment.author.abbrev_name}. also commented on #{@comment.bet.author.abbrev_name}.'s bet", link: bet_url(@comment.bet))
        end
      end
      @comment.bet.participants.each do |participant|
        next if @comment.author == participant || @comment.bet.commenters.include?(participant)
        Notification.create(user_id: participant.id, text: "#{@comment.author.abbrev_name}. also commented on #{@comment.bet.author.abbrev_name}.'s bet", link: bet_url(@comment.bet))
      end

      render partial: 'comments/show', locals: {comment: @comment}

    else
      render :json => "Could not save comment"
    end
  end

end

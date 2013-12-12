class CommentsController < ApplicationController

  def create
    @comment = Comment.new(params[:comment])
    @comment.bet_id = params[:bet_id]
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to bet_url(params[:bet_id])
    else
      render :json => "Could not save comment"
    end
  end

end

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.save

    @comments = Comment.where(prototype_id: params[:prototype_id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge({prototype_id: params[:prototype_id], user_id: current_user.id})
  end
end

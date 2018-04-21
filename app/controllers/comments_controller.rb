class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(params[:prototype_id])
    else
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge({prototype_id: params[:prototype_id], user_id: current_user.id})
  end
end

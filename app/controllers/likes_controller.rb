class LikesController < ApplicationController

  def create
    @like = Like.new(like_params)
    @like.save
    @count = Like.where("prototype_id = #{params[:prototype_id]}").count

    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  
  def like_params
    params.permit(:prototype_id).merge(user_id: current_user.id)
  end
end

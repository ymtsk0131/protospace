class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]

  def index
    if params[:order_by].present?
      if params[:order_by] == "Popular"
        prototype_ids = Like.group(:prototype_id).order('count_prototype_id DESC').count(:prototype_id).keys
        ordered_prototypes = prototype_ids.map { |id| Prototype.find(id) }
        prototypes = Kaminari.paginate_array(ordered_prototypes)
      elsif params[:order_by] == "Newest"
        prototypes = Prototype.order('created_at DESC')
      end
    else
      prototypes = Prototype.all.order('created_at DESC')
    end

    @order_by = params[:order_by]
    @prototypes = prototypes.page(params[:page]).per(4)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: 'new' }), alert: 'New prototype was unsuccessfully created'
     end
  end

  def show
    @comments = @prototype.comments
  end

  def destroy
    if @prototype.user_id == current_user.id
      @prototype.destroy
    end
  end

  def edit
  end

  def update
    if @prototype.user_id == current_user.id
      @prototype.update(update_prototype_params)
      redirect_to ({ action: "show"}), notice: '更新しました'
    end
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:id, :content, :status]
    )
  end

  def update_prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      captured_images_attributes: [:content, :status, :_destroy, :id]
    )
  end
end

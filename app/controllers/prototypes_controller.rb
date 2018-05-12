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
    @prototype.tags.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      create_tags
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: 'new' }), alert: 'New prototype was unsuccessfully created'
     end
  end

  def create_tags
    tag_array = tag_params
    3.times do |i|
      name = tag_array[i.to_s]["name"]
      if name.blank?
        next
      end

      tag = Tag.find_or_create_by(name: name)
      PrototypeTag.create(prototype_id: @prototype.id, tag_id: tag.id)
    end
  end

  def show
    @comments = @prototype.comments
  end

  def destroy
    if @prototype.user_id == current_user.id
      @prototype.destroy
      redirect_to ({ action: "index"}), notice: '削除しました'
    end
  end

  def edit
    unless @prototype.tags.count == 3
      3.times do |i|
        unless @prototype.tags[i]
          @prototype.tags.build
        end
      end
    end
  end

  def update
    if @prototype.user_id == current_user.id
      @prototype.update(update_prototype_params)
      update_tags
      redirect_to ({ action: "show"}), notice: '更新しました'
    end
  end

  def update_tags
    tag_array = tag_params
    3.times do |i|
      name = tag_array[i.to_s]["name"]
      if name.blank?
        if @prototype.prototype_tags[i]
          @prototype.prototype_tags[i].destroy
          @prototype.tags[i].destroy if @prototype.tags[i].prototype_tags.count == 0
        end

        next
      end

      tag = Tag.find_or_create_by(name: name)
      if @prototype.tags[i]
        if @prototype.tags[i].name != name
          prototype_tag = PrototypeTag.find_by(prototype_id: @prototype.id, tag_id: @prototype.tags[i].id)
          prototype_tag.update(tag_id: tag.id)
        end
      else
        PrototypeTag.create(prototype_id: @prototype.id, tag_id: tag.id)
      end
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

  def tag_params
    params.require(:prototype).permit(tags_attributes: [:name])[:tags_attributes]
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

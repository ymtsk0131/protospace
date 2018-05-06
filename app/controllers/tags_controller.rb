class TagsController < ApplicationController
  def index
    @tags = Tag.order("name ASC")
  end

  def show
    
  end
end

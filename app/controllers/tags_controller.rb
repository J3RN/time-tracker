class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :destroy]

  def index
    @tags = Tag.includes(:tasks)
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.create(tag_params)

    if @tag.save
      redirect_to tags_path
    else
      render 'new'
    end
  end

  def update
    @tag.update(tag_params)
    redirect_to tags_path
  end

  def destroy
    @tag.destroy
    redirect_to tags_path
  end

  private

    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name)
    end
end

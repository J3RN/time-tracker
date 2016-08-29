class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :destroy]
  before_action ->{ ensure_ownership(@tag) }, only: [:edit, :update, :destroy]

  def index
    @tags = Tag.includes(:tasks)

    @tags = @tags.where(user: current_user) unless current_user.admin?
    @tags = @tags.sort {|x, y| y.tasks.count <=> x.tasks.count}
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to tags_path
    else
      render 'new'
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render 'edit'
    end
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
      new_params = params.require(:tag).permit(:name, :user_id)
      new_params[:user_id] = current_user.id unless current_user.admin?
      new_params
    end
end

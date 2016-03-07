class TagsController < ApplicationController
  before_action :set_tag, except: [ :index, :new, :create ]
  before_action ->{ ensure_ownership(@tag) }, only: [:edit, :update, :destroy]

  respond_to :html, :json

  def index
    @tags = Tag.includes(:tasks)

    @tags = @tags.where(user: current_user) unless current_user.admin?
    @tags = @tags.sort {|x, y| y.tasks.count <=> x.tasks.count}

    respond_with(@tags)
  end

  def show
    respond_with(@tag)
  end

  def new
    @tag = Tag.new
  end

  def edit
  end

  def create
    @tag = Tag.create(tag_params)
    flash[:notice] = "Tag successfully created" if @tag.save
    respond_with(@tag)
  end

  def update
    @tag.update(tag_params)
    respond_with(@tag)
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

class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :set_tags, only: [:new, :edit]
  respond_to :html

  def index
    @tasks = Task.includes(:tags)

    @active = @tasks.active.order(priority: :desc)
    @archived = @tasks.archived.order_last_touched
  end

  def new
    @task = Task.new
    respond_with(@task)
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def update
    @task.update(task_params)
    redirect_to tasks_path
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def set_tags
      @tags = Tag.all
    end

    def task_params
      params.require(:task).permit(:task_name, :estimate, :archived, :priority,
                                   tag_ids: [])
    end
end

class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]
  before_action :set_tags, only: [:new, :edit]
  before_action :set_users, only: [:new, :edit]
  before_action ->{ ensure_ownership(@task) }, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.includes(:tags)

    @tasks = @tasks.where(user: current_user) unless current_user.admin?

    @active = @tasks.active
    @archived = @tasks.unscoped.archived.order(archived_at: :desc)
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path
    else
      set_tags
      set_users
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
      @tags = @tags.where(user: current_user) unless current_user.admin?
    end

    def set_users
      @users = User.all if current_user.admin?
    end

    def task_params
      new_params = params.require(:task).permit(:task_name, :estimate,
                                                :archived_at, :priority,
                                                :user_id, :due_date,
                                                tag_ids: [])
      new_params[:user_id] = current_user.id unless current_user.admin?
      new_params
    end
end

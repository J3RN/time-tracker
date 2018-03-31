class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy, :complete,
                                  :uncomplete]
  before_action :set_tags, except: [:complete, :uncomplete, :destroy]
  before_action :set_users, except: [:complete, :uncomplete, :destroy]
  before_action -> { ensure_ownership(@task) }, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.includes(:tags)

    @tasks = @tasks.where(user: current_user) unless current_user.admin?

    @active = @tasks.active.order_todo
    @completed = @tasks.completed.order(completed_at: :desc)
  end

  def new
    @task = Task.new
  end

  def edit; end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render "new"
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render "edit"
    end
  end

  def complete
    @task.update(completed_at: Time.now)
    redirect_to tasks_path
  end

  def uncomplete
    @task.update(completed_at: nil)
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
                                              :completed_at, :priority,
                                              :user_id, :due_date, :start_date,
                                              tag_ids: [])

    format_params(new_params)
  end

  def format_params(new_params)
    new_params[:user_id] = current_user.id unless current_user.admin?

    if new_params[:due_date].present?
      new_params[:due_date] = Date.american_date(new_params[:due_date])
    end

    if new_params[:start_date].present?
      new_params[:start_date] = Date.american_date(new_params[:start_date])
    end

    new_params
  end
end

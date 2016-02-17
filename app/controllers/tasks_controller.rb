class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_projects, only: [:edit, :new]
  respond_to :html

  def index
    @tasks = Task.includes(:time_entries, project: [:customer])
    @tasks = @tasks.order_last_touched

    @active = @tasks.active
    @archived = @tasks.archived
  end

  def new
    @task = Task.new
    respond_with(@task)
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.save
    redirect_to tasks_path
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

    def set_projects
      @projects = Project.includes(:customer).map { |project| ["#{project.customer.company} - #{project.project_name}", project.id]}
    end

    def task_params
      params.require(:task).permit(:task_name, :project_id, :estimate,
                                   :archived)
    end
end

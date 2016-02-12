class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_projects, only: [:edit, :new]
  respond_to :html

  def index
    @tasks = Task.includes(:project, project: [:customer]).order('customers.company,projects.project_name')
    respond_with(@tasks)
  end

  def show
    respond_with(@task)
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
    respond_with(@task)
  end

  def update
    @task.update(task_params)
    respond_with(@task)
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def set_projects
      @projects = Project.includes(:customer).map { |project| ["#{project.customer.company} - #{project.project_name}", project.id]}
    end

    def task_params
      params.require(:task).permit(:task_name)
    end
end

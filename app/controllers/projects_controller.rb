class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_customers, only: [:new, :edit]

  respond_to :html

  def index
    @projects = Project.all.includes(:customer).order('customers.company')
    respond_with(@projects)
  end

  def show
    respond_with(@project)
  end

  def new
    @project = Project.new
    respond_with(@project)
  end

  def edit
  end

  def create
    @project = Project.new(project_params)
    @project.save
    respond_with(@project)
  end

  def update
    @project.update(project_params)
    respond_with(@project)
  end

  def destroy
    @project.destroy
    respond_with(@project)
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def set_customers
      @customers = Customer.all.map { |x| [x.company, x.id] }
    end

    def project_params
      params.require(:project).permit(:project_name, :customer_id)
    end
end

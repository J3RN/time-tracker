require 'csv'

class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy,
                                        :stop_time, :start_time]
  before_action :set_tasks, only: [:new, :edit]
  respond_to :html

  def index
    if current_user.admin?
      @time_entries = TimeEntry.all
      @customers = Customer.all
    else
      @time_entries = current_user.time_entries
    end

    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @time_entries = @time_entries.where("start_time >= ?", @date.to_time)
    @time_entries = @time_entries.where("start_time < ?", (@date + 1.day).to_time)

    @time_entries = @time_entries.order(:start_time)

    @total = @time_entries.sum(:duration) / 60.0
    respond_to do |format|
      format.html
      format.csv { send_data @time_entries.to_csv }
    end
  end

  def show
    respond_with(@time_entry)
  end

  def new
    @time_entry = TimeEntry.new
    respond_with(@time_entry)
  end

  def edit
  end

  def create
    @time_entry = TimeEntry.new(time_entry_params)
    @time_entry.user = current_user
    @time_entry.start_time = DateTime.now
    @time_entry.duration = 0 if @time_entry.duration.nil?
    @time_entry.save

    redirect_to time_entries_path
  end

  def start_time
    @time_entry.start_time = DateTime.now
    @time_entry.running = true

    @time_entry.save

    redirect_to time_entries_path
  end

  def stop_time
    duration = ((DateTime.now.to_i - @time_entry.start_time.to_i)/60.0).round
    @time_entry.duration += duration
    @time_entry.running = false
    @time_entry.save

    redirect_to time_entries_path
  end

  def update
    @time_entry.update(time_entry_params)

    redirect_to time_entries_path
  end

  def destroy
    @time_entry.destroy
    respond_with(@time_entry)
  end

  def report
    customer_id = params[:customer_id]

    if customer_id
      @time_entries = TimeEntry.where(customer_id: customer_id)
      @projects = Customer.find(customer_id).projects
    else
      redirect_to time_entries_path
    end
  end

  private
    def set_tasks
      @tasks = Task.includes(:project, :customer).order('customers.company,projects.project_name,tasks.task_name')
      @tasks = @tasks.map { |x| ["#{x.customer.company} - #{x.project.project_name} - #{x.task_name}", x.id] }
    end

    def set_time_entry
      @time_entry = TimeEntry.find(params[:id])
    end

    def time_entry_params
      params.require(:time_entry).permit(:user_id, :task_id, :duration, :start_time, :note, :running, :goal, :result)
    end
end

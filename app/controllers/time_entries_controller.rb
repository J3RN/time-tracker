require 'csv'

class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy,
                                        :stop_time, :start_time]
  before_action :set_tasks, only: [:new, :edit]
  before_action :set_tag, only: [:report]
  before_action -> { ensure_ownership(@tag) }, only: [:report]
  respond_to :html

  def index
    @time_entries = TimeEntry.all

    @admin = current_user.admin?

    # Tags for reporting
    @tags = current_user.admin ? Tag.all : Tag.where(user: current_user)

    # Only my entries if not admin
    @time_entries = @time_entries.where(user: current_user) unless @admin

    # If there's a date, make sure all time entries are from that date
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @time_entries = @time_entries.filter_by_date(@date)

    # Total time for today
    @total = @time_entries.sum(:duration)

    # Include tasks and tags
    @time_entries.includes(task: :tags)

    # Most recent first
    @time_entries = @time_entries.order(start_time: :desc)
  end

  def show
    respond_with(@time_entry)
  end

  def new
    @time_entry = TimeEntry.new(running: true)
    respond_with(@time_entry)
  end

  def edit
  end

  def create
    @time_entry = TimeEntry.new(time_entry_params)
    @time_entry.user = current_user
    @time_entry.start_time ||= DateTime.now
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
    @time_entry.duration = @time_entry.calculate_duration
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
    redirect_to time_entries_path, alert: "No tag provided!" unless @tag

    @tasks = @tag.tasks.includes(:time_entries).order_last_touched
  end

  def export
    @time_entries = TimeEntry.includes(task: [:tags])
    @time_entries = @time_entries.where(user: current_user) if !current_user.admin?
    send_data @time_entries.to_csv
  end

  private
    def set_tasks
      @tasks = Task.includes(:time_entries, :tags)
      @tasks = @tasks.where(user: current_user) unless current_user.admin?
      @tasks = @tasks.active
      @tasks = @tasks.map { |task| [ task.explicit_name, task.id ]}
    end

    def set_tag
      @tag = Tag.find(params[:tag_id])
    end

    def set_time_entry
      @time_entry = TimeEntry.find(params[:id])
    end

    def time_entry_params
      new_params = params.require(:time_entry).permit(:user_id, :task_id,
                                                      :duration, :start_time,
                                                      :note, :running, :goal,
                                                      :result)
      new_time = DateTime.strptime(new_params[:start_time], "%m/%d/%Y %H:%M %p")
      new_params[:start_time] = new_time
      new_params
    end
end

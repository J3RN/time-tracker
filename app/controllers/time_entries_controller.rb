require 'csv'

class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy,
                                        :stop_time, :start_time]
  before_action :set_tasks, only: [:new, :edit, :create, :update]
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
    @time_entry = TimeEntry.new(running: true, start_time: Time.now)
    respond_with(@time_entry)
  end

  def edit
  end

  def create
    @time_entry = TimeEntry.new(time_entry_params)
    @time_entry.user = current_user
    @time_entry.start_time ||= DateTime.now

    if @time_entry.save
      redirect_to time_entries_path(date: @time_entry.start_time.to_date)
    else
      render 'new'
    end
  end

  def start_time
    @time_entry.start_time = DateTime.now
    @time_entry.running = true
    if @time_entry.save
      redirect_to time_entries_path
    else
      redirect_to time_entries_path, alert: "Failed to start timer"
    end
  end

  def stop_time
    @time_entry.duration = @time_entry.calculate_duration
    @time_entry.running = false
    if @time_entry.save
      redirect_to time_entries_path
    else
      redirect_to time_entries_path, alert: "Failed to stop timer"
    end
  end

  def update
    if @time_entry.update(time_entry_params)
      redirect_to time_entries_path(date: @time_entry.start_time.to_date)
    else
      render 'edit'
    end
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
      @tasks = @tasks.active.order_todo
      if @time_entry.try(:task) and @tasks.exclude? @time_entry.task
        @tasks << @time_entry.task
      end
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

      if new_params[:running] == "1"
        new_params = remove_stopped_elements(new_params)
      else
        new_params[:start_time] = Time.zone.local_to_utc(Time.american_date(new_params[:start_time]))
      end

      new_params
    end

    def remove_stopped_elements(new_params)
      new_params.reject { |key, _| [:duration, :start_time, :result].include? key.to_sym }
    end
end

class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :edit, :update, :destroy, :stop_time]

  respond_to :html

  def index
    @time_entries = current_user.time_entries
    respond_with(@time_entries)
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
    @time_entry.save
    respond_with(@time_entry)
  end

  def stop_time
    duration = ((DateTime.now.to_i - @time_entry.start_time.to_i)/60.0).round
    @time_entry.duration = duration
    @time_entry.save

    redirect_to time_entries_path
  end

  def update
    @time_entry.update(time_entry_params)
    respond_with(@time_entry)
  end

  def destroy
    @time_entry.destroy
    respond_with(@time_entry)
  end

  private
    def set_time_entry
      @time_entry = TimeEntry.find(params[:id])
    end

    def time_entry_params
      params.require(:time_entry).permit(:project_id, :user_id, :task_id, :duration, :start_time, :note)
    end
end

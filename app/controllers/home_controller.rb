class HomeController < ApplicationController
  skip_before_action :authenticate_user!, except: :dashboard
  respond_to :html

  def index
    redirect_to time_entries_url if user_signed_in?
  end

  def dashboard
    ## Main objects
    @admin = current_user.admin?
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @tasks = Task.includes(:tags)
    @time_entries = TimeEntry.all
    @tags = Tag.all

    # Limit to just ours if we're not an admin
    unless @admin
      @tasks = @tasks.where(user: current_user)
      @time_entries = @time_entries.where(user: current_user)
      @tags.where(user: current_user)
    end

    ## Group
    @active = @tasks.active
    @archived = @tasks.unscoped.archived.order(archived_at: :desc)

    ## Time Sorting
    # If there's a date, make sure all time entries are from that date
    @time_entries = @time_entries.filter_by_date(@date)
    # Total time for today
    @total = @time_entries.sum(:duration)
    # Include tasks and tags
    @time_entries.includes(task: :tags)
    # Most recent first
    @time_entries = @time_entries.order(start_time: :desc)
  end
end

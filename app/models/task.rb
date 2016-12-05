class Task < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :time_entries, dependent: :destroy
  belongs_to :user

  validates_presence_of :user_id, :task_name

  scope :order_last_touched, -> do
    includes(:time_entries).order('time_entries.start_time DESC')
  end
  scope :active, -> { where(archived_at: nil) }
  scope :archived, -> { where.not(archived_at: nil) }

  def self.order_todo
    tasks = all.sort_by { |x| -x.due_today }

    today = tasks.reject { |x| x.time_remaining_today.zero? }
    today.sort_by! { |x| -x.priority }

    not_today = tasks.select { |x| x.time_remaining_today.zero? }
    not_today.sort_by! { |x| -x.priority }

    today + not_today
  end

  def time_spent
    self.time_entries.total_real_duration
  end

  def percent_time_used
    if self.estimate.nil? || self.estimate.zero?
      return 0
    end

    (self.time_spent.to_f / self.estimate) * 100
  end

  def explicit_name
    "#{self.task_name} - #{self.tags.pluck(:name).join(", ")}"
  end

  def archived?
    self.archived_at.present?
  end

  def days_left
    (self.due_date - Date.today).to_i if self.due_date
  end

  def overdue?
    !archived? && days_left.present? && days_left < 0
  end

  def time_remaining_today
    left_today = due_today - done_today

    if left_today < 0
      0
    else
      left_today
    end
  end

  def due_today
    return 0 unless estimate && due_date
    return 0 if start_date && start_date > Date.today

    work_left = estimate - done_before_today

    if due_date > Date.today
      work_left / days_left.to_f
    else
      work_left
    end
  end

  private

  def done_before_today
    today = Date.today.to_time
    entries_before_today = time_entries.where('start_time < ?', today)
    entries_before_today.total_real_duration
  end

  def done_today
    today = Date.today.to_time
    todays_entries = time_entries.where('start_time >= ?', today)
    todays_entries.total_real_duration
  end
end

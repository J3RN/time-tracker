class Task < ActiveRecord::Base
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
    tasks = order(priority: :desc)
    today = tasks.reject { |x| x.time_remaining_today.zero? }
    not_today = tasks.select { |x| x.time_remaining_today.zero? }

    today + not_today
  end

  def time_spent
    self.time_entries.sum(:duration)
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
    return 0 unless self.due_date && self.estimate

    today = Date.today.to_time

    entries_before_today = self.time_entries.where("start_time < ?", today)
    done_before_today = entries_before_today.sum(:duration)

    per_day = self.estimate - done_before_today

    if self.due_date > Date.today
      per_day = per_day / days_left.to_f
    end

    todays_entries = self.time_entries.where("start_time >= ? AND start_time < ?", today, today + 1.days)
    done_today = todays_entries.sum(:duration)

    per_day - done_today
  end
end

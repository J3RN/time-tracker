class Task < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :time_entries, dependent: :destroy
  belongs_to :user

  validates_presence_of :user_id, :task_name

  default_scope { order(due_date: :asc, priority: :desc, estimate: :desc) }
  scope :order_last_touched, -> do
    includes(:time_entries).order('time_entries.start_time DESC')
  end
  scope :active, -> { where(archived_at: nil) }
  scope :archived, -> { where.not(archived_at: nil) }

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
end

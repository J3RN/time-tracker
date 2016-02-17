class Task < ActiveRecord::Base
  belongs_to :project
  has_many :time_entries
  has_one :customer, through: :project

  validates_presence_of :project

  scope :order_last_touched, -> do
    includes(:time_entries).order('time_entries.start_time DESC')
  end
  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  def time_spent
    self.time_entries.sum(:duration)
  end

  def percent_time_used
    if self.estimate.nil? || self.estimate.zero?
      return 0
    end

    (self.time_spent.to_f / self.estimate) * 100
  end
end

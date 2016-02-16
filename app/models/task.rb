class Task < ActiveRecord::Base
  belongs_to :project
  has_many :time_entries
  has_one :customer, through: :project

  validates_presence_of :project

  def time_spent
    self.time_entries.sum(:duration)
  end

  def percent_time_used
    if self.estimate.nil? || self.estimate.zero?
      return 0
    end

    (self.time_spent.to_f / self.estimate) * 100
  end

  def last_touched
    self.time_entries.order(:start_time).try(:last).try(:start_time) || DateTime.new
  end
end

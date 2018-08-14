require "csv"

class TimeEntry < ApplicationRecord
  belongs_to :user
  belongs_to :task
  has_many :tags, through: :task

  validates_presence_of :task_id
  validates_presence_of :user_id

  scope :filter_by_date, lambda { |date|
    today = date.to_time
    tomorrow = (date + 1.day).to_time

    where("start_time >= ?", today).where("start_time < ?", tomorrow)
  }

  scope :running, lambda {
    where(running: true)
  }

  scope :overrun, lambda {
    running.where("start_time < ?", Date.today.to_time)
  }

  def real_duration
    if running?
      ((Time.now.to_i - start_time.to_i) / 60.0).round
    else
      duration
    end
  end

  def end_time
      start_time + (real_duration * 60)
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end

  def self.total_real_duration
    all.map(&:real_duration).sum
  end
end

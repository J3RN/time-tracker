require 'csv'

class TimeEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_many :tags, through: :task

  validates_presence_of :task_id
  validates_presence_of :user_id

  def real_duration
    if running?
      ((DateTime.now.to_i - start_time.to_i) / 60.0).round
    else
      duration
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end

  def self.filter_by_date(date)
    entries = self.where("start_time >= ?", date.to_time)
    entries.where("start_time < ?", (date + 1.day).to_time)
  end

  def self.total_real_duration
    all.map(&:real_duration).sum
  end
end

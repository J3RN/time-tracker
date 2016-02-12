require 'csv'

class TimeEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  has_one :project, through: :task
  has_one :customer, through: :project

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end
end

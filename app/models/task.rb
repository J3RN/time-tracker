class Task < ActiveRecord::Base
  belongs_to :project
  has_many :time_entries
  has_one :customer, through: :project

  validates_presence_of :project
end

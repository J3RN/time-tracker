class Project < ActiveRecord::Base
  belongs_to :customer
  has_many :tasks
  has_many :time_entries, through: :tasks

  validates_presence_of :customer
end

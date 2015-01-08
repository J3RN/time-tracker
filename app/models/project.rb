class Project < ActiveRecord::Base
  belongs_to :customer
  has_many :time_entries
end

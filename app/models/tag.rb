class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :tasks, through: :taggings
  has_many :time_entries, through: :tasks
  belongs_to :user

  validates_presence_of :user_id
end

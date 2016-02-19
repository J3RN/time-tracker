class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :tasks, through: :taggings
end

class User < ApplicationRecord
  # Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable

  has_many :time_entries, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :tasks, dependent: :destroy

  ADDITIONAL_FIELDS = [:username, :display_name].freeze
end

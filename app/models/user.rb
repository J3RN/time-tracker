class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :time_entries, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :tasks, dependent: :destroy
end

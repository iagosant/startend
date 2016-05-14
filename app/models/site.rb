class Site < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :shifts
  has_many :schedules, through: :shifts
  has_many :guards, through: :shifts
end

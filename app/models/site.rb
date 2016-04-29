class Site < ActiveRecord::Base
  has_many :shifts
  has_many :schedules, through: :shifts
  has_many :users, through: :shifts
end

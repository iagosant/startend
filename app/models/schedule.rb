class Schedule < ActiveRecord::Base
  has_many :shifts
  has_many :sites, through: :shifts
end

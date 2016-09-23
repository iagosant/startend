class Course < ActiveRecord::Base
  has_many :trainings
  has_many :guards, through: :trainings
end

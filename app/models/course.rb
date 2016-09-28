class Course < ActiveRecord::Base
  has_many :trainings
  has_many :guards, through: :trainings

  def completed?(user)
    !self.trainings.find_by(guard_id: user).completed_at.blank?
  end


end

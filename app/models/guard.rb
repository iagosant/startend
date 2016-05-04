class Guard < ActiveRecord::Base
  validates_uniqueness_of :first_name, scope: [:last_name]
  has_many :shifts
  has_many :sites, through: :shifts

  def self.find_days_shifts(guard, shift)


  end

end

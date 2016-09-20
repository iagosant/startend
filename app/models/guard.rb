class Guard < ActiveRecord::Base
  validates_uniqueness_of :first_name, scope: [:last_name]
  has_many :shifts
  has_many :sites, through: :shifts
  has_many :courses
  before_validation :set_fullname, only: [:save]


  def set_fullname
      fullname = "#{first_name} #{last_name}"
    end

end

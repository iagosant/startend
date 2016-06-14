class User < ActiveRecord::Base
  has_secure_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email

  #master => all access
  #admin => view, download, edit hours, delete guards, delete shifts
  #manager => view, download, edit hours
  #employee => view, download
  enum role: [:master, :admin, :manager, :employee]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    #  byebug
    self.role ||= :employee
  end

end

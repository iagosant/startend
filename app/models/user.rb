class User < ActiveRecord::Base
  has_secure_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email

end

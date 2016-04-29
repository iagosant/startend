class Shift < ActiveRecord::Base
  belongs_to :site
  belongs_to :schedule
  belongs_to :user
end

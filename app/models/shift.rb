class Shift < ActiveRecord::Base
  validates_uniqueness_of :datetime, scope: [:user_id]
  belongs_to :site
  belongs_to :schedule
  belongs_to :user
end

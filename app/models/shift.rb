class Shift < ActiveRecord::Base
  validates_uniqueness_of :datetime, scope: [:guard_id]
  belongs_to :site
  belongs_to :schedule
  belongs_to :guard


end

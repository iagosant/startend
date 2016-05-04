class Shift < ActiveRecord::Base
  validates_uniqueness_of :datetime, scope: [:guard_id]
  belongs_to :site
  belongs_to :schedule
  belongs_to :guard

  def self.shift_info
     Shift.all.each do |shift|
     @day = shift.datetime.strftime("%A")
     @clock = shift.datetime.strftime('%H:%M')
   end
  end

end

class Training < ActiveRecord::Base
  belongs_to :course
  belongs_to :guard
end

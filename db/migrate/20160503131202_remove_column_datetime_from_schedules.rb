class RemoveColumnDatetimeFromSchedules < ActiveRecord::Migration
  def up
    remove_column :schedules, :datetime
  end
  def down
    add_column :schedules, :datetime, :datetime
  end
end

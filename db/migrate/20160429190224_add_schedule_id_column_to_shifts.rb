class AddScheduleIdColumnToShifts < ActiveRecord::Migration
  def up
    add_column :shifts, :schedule_id, :integer
  end
  def down
    remove_column :shifts, :schedule_id, :integer
  end
end

class RemoveColumnOnShiftFromSchedules < ActiveRecord::Migration
  def up
    remove_column :schedules, :on_shift
  end
  def down
    add_column :schedules, :on_shift, :boolean, :default => false
  end
end

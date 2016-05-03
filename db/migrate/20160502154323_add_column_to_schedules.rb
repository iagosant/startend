class AddColumnToSchedules < ActiveRecord::Migration
  def up
    add_column :schedules, :on_shift, :boolean, :default => false
  end
  def down
    remove_column :schedules, :on_shift, :boolean, :default => false
  end
end

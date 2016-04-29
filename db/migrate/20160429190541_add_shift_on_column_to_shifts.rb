class AddShiftOnColumnToShifts < ActiveRecord::Migration
  def up
    add_column :shifts, :on_shift, :boolean, :default => false
  end
  def down
    remove_column :shifts, :on_shift, :boolean, :default => false
  end
end

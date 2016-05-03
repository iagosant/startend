class RemoveOnShiftColumnFromShifts < ActiveRecord::Migration
  def up
    remove_column :shifts, :on_shift
  end
  def down
    add_column :shifts, :on_shift, :boolean, :default => false
  end
end

class AddColumnToShifts < ActiveRecord::Migration
  def up
    add_column :shifts, :datetime, :datetime
  end
  def down
    remove_column :shifts, :datetime, :datetime
  end
end

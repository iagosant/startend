class AddColumnsToShifts < ActiveRecord::Migration
  def up
    add_column :shifts, :user_id, :integer
  end
  def down
    remove_column :shifts, :user_id, :integer
  end
end

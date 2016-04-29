class RemoveColumnFromShifts < ActiveRecord::Migration
  def change
    remove_column :shifts, :schedule_id, :integer
  end
end

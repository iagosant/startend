class AddSiteIdColumnToShifts < ActiveRecord::Migration
  def up
    add_column :shifts, :site_id, :integer
  end
  def down
    remove_column :shifts, :site_id, :integer
  end
end

class AddColumnToSearch < ActiveRecord::Migration
  def up
    add_column :searches, :search_date, :datetime
  end
  def down
    remove_column :searches, :search_date, :datetime
  end
end

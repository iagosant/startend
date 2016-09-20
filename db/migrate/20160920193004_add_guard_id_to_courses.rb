class AddGuardIdToCourses < ActiveRecord::Migration
  def up
    add_column :courses, :guard_id, :integer, index: true
  end
  def down
    remove_column :courses, :guard_id
  end
end

class AddColumnCompletedAtToTraining < ActiveRecord::Migration
  def up
    add_column :trainings, :completed_at, :datetime
  end
  def down
    remove_column :trainings, :completed_at, :datetime
  end
end

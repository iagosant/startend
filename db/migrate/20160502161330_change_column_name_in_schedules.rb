class ChangeColumnNameInSchedules < ActiveRecord::Migration
  def change
    rename_column :schedules, :date, :datetime
  end
end

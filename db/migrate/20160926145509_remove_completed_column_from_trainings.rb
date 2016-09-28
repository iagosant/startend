class RemoveCompletedColumnFromTrainings < ActiveRecord::Migration
  def change
    remove_column :trainings, :completed
  end
end

class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.boolean :completed, default: :false
      t.belongs_to :course, index: true
      t.belongs_to :guard, index: true
      t.timestamps null: false
    end
  end
end

class CreateJoinTableCourseGuard < ActiveRecord::Migration
  def change
    create_join_table :courses, :guards do |t|
      t.index [:course_id, :guard_id]
      t.index [:guard_id, :course_id]
    end
  end
end

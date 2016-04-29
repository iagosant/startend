class DropSitesSchedulesTable < ActiveRecord::Migration
  def up
  drop_table :sites_schedules
end

def down
  raise ActiveRecord::IrreversibleMigration
end
end

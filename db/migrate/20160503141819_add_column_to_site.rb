class AddColumnToSite < ActiveRecord::Migration
  def up
    add_column :sites, :codename, :string
  end
  def down
    remove_column :sites, :codename, :string
  end
end

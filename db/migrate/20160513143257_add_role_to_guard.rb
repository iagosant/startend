class AddRoleToGuard < ActiveRecord::Migration
  def up
    add_column :guards, :role, :string
  end
  def down
    remove_column :guards, :role, :string
  end
end

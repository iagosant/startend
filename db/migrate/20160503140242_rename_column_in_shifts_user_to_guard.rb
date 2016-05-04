class RenameColumnInShiftsUserToGuard < ActiveRecord::Migration
  def change
    rename_column :shifts, :user_id, :guard_id
  end
end

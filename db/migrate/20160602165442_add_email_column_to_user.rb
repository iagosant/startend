class AddEmailColumnToUser < ActiveRecord::Migration
  def up
    add_column :users, :email, :string
    add_column :users, :password_digest, :string
  end
  def down
    remove_column :users, :email, :string
    remove_column :users, :password_digest, :string
  end
end

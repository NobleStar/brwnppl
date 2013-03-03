class AddIsAdminColumnToUsers < ActiveRecord::Migration
  def up
    add_column :users, :is_admin, :boolean, :default => false
  end

  def method_name
    remove_column :users, :is_admin, :boolean
  end
end

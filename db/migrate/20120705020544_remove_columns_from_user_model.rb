class RemoveColumnsFromUserModel < ActiveRecord::Migration
  def up
    remove_column :users, :crypted_password
    remove_column :users, :salt

    add_column :users, :name, :string
  end

  def down
    add_column :users, :crypted_password, :string
    add_column :users, :salt, :string

    remove_column :users, :name
  end
end

class AddUseTypeToUsers < ActiveRecord::Migration
  def up
    add_column :users, :account_type, :string, :default => 'personal'
  end

  def down
    remove_column :users, :account_type
  end
end

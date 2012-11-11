class AddStateColumnToUser < ActiveRecord::Migration
  def up
    add_column :users, :state, :string
  end

  def down
    remove_column :users, :state
  end
end

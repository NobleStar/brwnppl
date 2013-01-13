class ChangeBrowniePointsColumnDefault < ActiveRecord::Migration
  def up
    change_column :stories, :brownie_points, :integer, :default => 0
    change_column :users, :brownie_points, :integer, :default => 0
    change_column :users, :share_activity_on_facebook, :boolean, :default => true
  end

  def down
  end
end

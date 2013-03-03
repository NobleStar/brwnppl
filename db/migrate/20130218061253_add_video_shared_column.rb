class AddVideoSharedColumn < ActiveRecord::Migration
  def up
    add_column :users, :video_shared, :boolean, default: false
  end

  def down
    remove_column :users, :video_shared
  end
end

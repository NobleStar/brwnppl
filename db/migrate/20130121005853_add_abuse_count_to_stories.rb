class AddAbuseCountToStories < ActiveRecord::Migration
  def up
    add_column :stories, :abuse_count, :integer, :default => 0
  end

  def down
    remove_column :stories, :abuse_count
  end
end

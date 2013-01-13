class AddReshareBooleanColumnToStory < ActiveRecord::Migration
  def up
    add_column :stories, :reshared, :boolean, :default => false
    add_column :stories, :original_story_id, :integer
    add_column :stories, :reshare_count, :integer, :default => 0
  end

  def down
    remove_column :stories, :reshared
    remove_column :stories, :original_story_id
    remove_column :stories, :reshare_count
  end
end

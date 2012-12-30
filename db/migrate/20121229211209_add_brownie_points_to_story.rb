class AddBrowniePointsToStory < ActiveRecord::Migration

  def up
    add_column :stories, :brownie_points, :integer, :default => 0

    Story.all.each do |story|
      story.brownie_points = story.likes_count
      story.save
    end
  end

  def down
    remove_column :stories, :brownie_points
  end

end

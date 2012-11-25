class AddCommunityIdColumnToStory < ActiveRecord::Migration
  
  def up
    add_column :stories, :community_id, :integer
  end

  def down
    remove_column :stories, :community_id
  end

end

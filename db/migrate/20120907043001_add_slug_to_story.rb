class AddSlugToStory < ActiveRecord::Migration

  def up
    add_column :stories, :slug, :string, null: false, default: ""
    add_index :stories, :slug
  end

  def down
    remove_column :stories, :slug
  end

end

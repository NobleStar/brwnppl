class AddContentTypeOnStory < ActiveRecord::Migration
  
  class Story < ActiveRecord::Base
    set_table_name 'stories'
  end

  class ContentType < ActiveRecord::Base
    set_table_name 'content_types'
  end

  def up
    add_column :stories, :content_type, :string

    AddContentTypeOnStory::Story.all.each do |story|
      story.content_type = AddContentTypeOnStory::ContentType.all.sample.internal_name
      story.save
    end
  end

  def down
    remove_column :stories, :content_type
  end
end

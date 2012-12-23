class AddNewStoryTypesModel < ActiveRecord::Migration
  
  class ContentType < ActiveRecord::Base
    set_table_name 'content_types'
  end

  def up
    create_table :content_types do |t|
      t.integer :id
      t.string :internal_name
      t.string :public_name
      t.timestamps
    end

    AddNewStoryTypesModel::ContentType.create!( :internal_name => 'discussion', :public_name => 'Discussion')
    AddNewStoryTypesModel::ContentType.create!( :internal_name => 'web_link', :public_name => 'Web Link')
    AddNewStoryTypesModel::ContentType.create!( :internal_name => 'audio', :public_name => 'Audio')
    AddNewStoryTypesModel::ContentType.create!( :internal_name => 'video', :public_name => 'Video')
    AddNewStoryTypesModel::ContentType.create!( :internal_name => 'image', :public_name => 'Image')
  end

  def down
    drop_table :content_types
  end
end

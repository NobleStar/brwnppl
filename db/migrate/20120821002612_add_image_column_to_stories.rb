class AddImageColumnToStories < ActiveRecord::Migration
  
  def self.up
  	add_column :stories, :image, :string
  end

  def self.down
  	remove_column :stories, :image
  end
end

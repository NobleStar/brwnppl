class AddIsStaffPostColumnToStories < ActiveRecord::Migration
  
  def up
    add_column :stories, :is_staff_post, :boolean, :default => false
  end

  def down
    remove_column :stories, :is_staff_post
  end
end

class AddCommentsTable < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.integer :story_id
      t.integer :user_id
      t.text :content
      t.timestamps
    end
  end

  def down
    drop_table :comments
  end
end

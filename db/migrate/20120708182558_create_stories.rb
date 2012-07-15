class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.text :description
      t.string :type
      t.text :url

      t.timestamps
    end
  end
end

class AddCommunitiesTable < ActiveRecord::Migration
  def up
    create_table :communities do |t|
      t.timestamps
      t.string :name
      t.string :slug
    end
  end

  def down
    drop_table :communities
  end
end

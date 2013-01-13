class AddUserSettingToShareFacebookActivity < ActiveRecord::Migration
  def up
    add_column :users, :share_activity_on_facebook, :boolean
  end

  def down
    remove_column :users, :share_activity_on_facebook
  end
end

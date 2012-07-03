class RemoveSorcerySubmodules < ActiveRecord::Migration
  
  def up
    remove_index :users, :remember_me_token
    remove_column :users, :remember_me_token_expires_at
    remove_column :users, :remember_me_token

    remove_index :users, :reset_password_token
    remove_column :users, :reset_password_email_sent_at
    remove_column :users, :reset_password_token_expires_at
    remove_column :users, :reset_password_token
  end

  def down
    add_column :users, :remember_me_token, :string, :default => nil
    add_column :users, :remember_me_token_expires_at, :datetime, :default => nil
    add_index :users, :remember_me_token

    add_column :users, :reset_password_token, :string, :default => nil
    add_column :users, :reset_password_token_expires_at, :datetime, :default => nil
    add_column :users, :reset_password_email_sent_at, :datetime, :default => nil
    add_index :users, :reset_password_token
  end

end

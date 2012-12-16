class AddBrowniePointToUser < ActiveRecord::Migration
    
  class User < ActiveRecord::Base
    set_table_name 'users'
  end

  def up
    add_column :users, :brownie_points, :integer, :default => 0
    AddBrowniePointToUser::User.where(:brownie_points => nil).each do |u|
      u.brownie_points = 0
      u.save
    end
  end

  def down
    remove_column :users, :brownie_points  
  end

end

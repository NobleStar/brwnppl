class SetCommunitiesForNill < ActiveRecord::Migration
  class Story < ActiveRecord::Base
    set_table_name 'stories'
  end

  def up
    SetCommunitiesForNill::Story.where(:community_id => nil).each do |s|
      s.community_id = 1
      s.save
    end
  end

  def down
  end
end

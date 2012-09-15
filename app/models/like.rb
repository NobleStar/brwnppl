class Like < ActiveRecord::Base
  
  belongs_to :story
  belongs_to :user
  validates_uniqueness_of :story_id, scope: :user_id

end
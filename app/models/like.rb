class Like < ActiveRecord::Base
  
  belongs_to :story
  belongs_to :user
  validates_uniqueness_of :story_id, scope: :user_id

  after_save :increment_brownie_points

  def increment_brownie_points
    user = self.story.user
    user.brownie_points += 1
    user.save
  end

end
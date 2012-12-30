class Dislike < ActiveRecord::Base

  belongs_to :story
  belongs_to :user
  validates_uniqueness_of :story_id, scope: :user_id

  after_save :decrement_brownie_points

  def decrement_brownie_points
    # user brownie points
    user = self.story.user
    user.brownie_points -= 1
    user.save

    # story brownie points
    self.story.brownie_points -= 1
    story.save
  end

end

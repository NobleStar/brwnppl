class Like < ActiveRecord::Base
  
  belongs_to :story
  belongs_to :user

  after_save :increment_brownie_points

  def increment_brownie_points
    # user brownie points
    user = self.story.user
    user.brownie_points += 1
    user.save

    # story brownie points
    self.story.brownie_points += 1
    self.story.save
  end

end
class Relationship < ActiveRecord::Base

  attr_accessible :followed_id
  
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, presence: true
  validates :followed_id, presence: true

  validate :should_not_be_self

  def should_not_be_self
    errors.add(:base, "you cannot follow yourself") if follower_id == followed_id
  end
end

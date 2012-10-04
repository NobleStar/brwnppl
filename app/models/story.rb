class Story < ActiveRecord::Base

  scope :latest, :order => 'created_at DESC'

  belongs_to :user
  
  has_many :likes
  has_many :likers, through: :likes, source: :user
  
  has_many :comments
  has_many :commenters, through: :comments, source: :user
  
  validates_format_of :url, :with => URI::regexp(%w(http https))
  validates_presence_of :url, :title

  include FriendlyId
  friendly_id :title, :use => [:slugged, :history]

  def likes_count
    likes.count
  end

  def comments_count
    comments.count
  end

  def liked_by(user)
    likes << likes.build(:user => user)
  end

end

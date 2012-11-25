class Story < ActiveRecord::Base

  attr_accessor :oauth_token
  after_save :post_to_facebook, :if => :owner_is_from_facebook?

  scope :latest, :order => 'created_at DESC'

  belongs_to :user
  belongs_to :community
  
  has_many :likes
  has_many :likers, through: :likes, source: :user
  
  has_many :comments
  has_many :commenters, through: :comments, source: :user
  
  validates_format_of :url, :with => URI::regexp(%w(http https))
  validates_presence_of :url, :title
  validates_presence_of :community

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

  def post_to_facebook
    facebook = Koala::Facebook::API.new(user.oauth_token)
    facebook.put_connections("me", "brwnppl:post", story: self.public_url)
  end
  handle_asynchronously :post_to_facebook, :run_at => Proc.new { 15.seconds.from_now }

  def public_url
    ENV['APP_URL'] + '/story/' + self.slug
  end

  def fb_image
    self.image.blank? ? ENV['APP_URL'] + '/assets/brwnppl-default.png' : self.image
  end

  def owner_is_from_facebook?
    self.user.authentications.map(&:provider).include?('facebook')
  end

  def self.recents
    # TODO - Add Logic for Recent Stories
    Story.latest
  end

  def self.populars
    # TODO - Add Logic for Popular Stories
    Story.first(15)
  end

  def self.by_community(slug)
    community = Community.find_by_slug(slug)
    
  end

end

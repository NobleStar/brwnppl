class Story < ActiveRecord::Base

  paginates_per 15

  attr_accessor :oauth_token
  attr_accessible :type, :url, :image, :title, :community_id, :description, :content_type
  after_create :post_to_facebook, :if => :owner_is_from_facebook_and_sharing_enabled?
  after_save   :expire_cache

  scope :latest, :order => 'created_at DESC'

  belongs_to :user
  belongs_to :community
  
  has_many :likes, :dependent => :destroy
  has_many :likers, through: :likes, source: :user

  has_many :dislikes, :dependent => :destroy
  has_many :dislikers, through: :dislikes, source: :user
  
  has_many :comments
  has_many :commenters, through: :comments, source: :user

  validates_presence_of :title, :community
  #validates_presence_of :content_type
  validates :title, :length => { :maximum => 140 }
  validates_uniqueness_of :url, :message => 'has already been posted.'
  validates_presence_of :content_type
  validate :last_post_was_2_minutes_ago
  validates_format_of :url, :with => URI::regexp(%w(http https))

  include FriendlyId
  friendly_id :title, :use => [:slugged, :history]

  def reshare(user)
    # questions for Humble: What about comments/brownie points etc?
    duplicate_story = self.dup
    duplicate_story.brownie_points = 0
    duplicate_story.user_id = user.id
    duplicate_story.reshared = true
    duplicate_story.original_story_id = self.id
    self.reshare_count += 1
    ActiveRecord::Base.transaction do
      self.save
      duplicate_story.save
    end
  end

  def self.recent_for(user_ids)
    where( :user_id => user_ids ).order('created_at DESC').limit(1000)
  end

  def report_abuse
    self.abuse_count += 1
    self.save
  end

  def likes_count
    likes.size
  end

  def dislikes_count
    dislikes.size
  end

  def comments_count
    comments.size
  end

  def liked_by(user)
    if user.is_admin || user.can_like_more?(self)
      likes.create(:user => user)
    end
  end

  def disliked_by(user)
    dislikes.create(:user => user)
  end

  def post_to_facebook
    facebook = Koala::Facebook::API.new(user.oauth_token)
    facebook.put_connections("me", "brwnppl:post", story: self.public_url)
  end
  handle_asynchronously :post_to_facebook, :run_at => Proc.new { 2.seconds.from_now }

  def public_url
    ENV['APP_URL'] + '/story/' + self.slug
  end

  def fb_image
    self.image.blank? ? ENV['APP_URL'] + '/assets/brwnppl-default.png' : self.image
  end

  def owner_is_from_facebook_and_sharing_enabled?
    self.user.facebook? and self.user.share_activity_on_facebook
  end

  def score
    likes.size - dislikes.size
  end

  def self.populars
    on_top = Story.find_by_id(350)
    # populars = Story.all( :joins => :community, :order => 'updated_at DESC, brownie_points DESC', :limit => 100 )
    stories = Story.find(:all, :include => [:likes, :dislikes, :comments, :user], :order => 'created_at DESC', :limit => 500)
    populars = stories.sort_by { |s| s.rank }.reverse!
    on_top.present? ? [on_top] + populars : populars
  end

  def rank
    score = self.score
    order = Math.log10([score.abs, 1].max)
    sign = score > 0 ? 1 : -1
    sign = 0 if score == 0
    seconds = self.created_at.to_i - 1134028003
    (order + sign*seconds/45000).round
  end

  def self.top(time)
    return Story.find(:all, :include => [:likes, :dislikes, :comments, :user], :order => 'brownie_points DESC, updated_at DESC', :limit => 1000) if time == 'all'
    return Story.where("DATE(created_at) = ?", Date.today).all(:order => 'brownie_points DESC, updated_at DESC', :include => [:likes, :dislikes, :comments, :user], :limit => 1000) if time == 'today'
  end

  def self.by_community(community)
    where(:community_id => community.id).order('updated_at DESC, brownie_points DESC').limit(20)
  end

  def self.recent_by_community(community)
    where(:community_id => community.id).order('created_at DESC')
  end

  def self.top_by_community(community)
    where(:community_id => community.id).order('brownie_points DESC').limit(1000)
  end

  def expire_cache
    a = ActionController::Base.new
    a.expire_fragment 'logged_in/popular/*'
    a.expire_fragment 'logged_in/recent/*'
    a.expire_fragment 'logged_out/recent'
    a.expire_fragment 'logged_out/popular'
  end

  def last_post_was_2_minutes_ago
    last_story = self.user.stories.last
    if last_story && (last_story.created_at + 2.minutes) > Time.zone.now
      errors.add(:base, "You need to wait atleast 2 minutes before making new posts.")
    end
  end

  def url_host
    URI.parse(self.url).host.gsub(/www./, '') rescue nil
  end

  def url_extension
    File.extname(URI.parse(self.url).path) rescue nil
  end

  def video?
    ['youtu.be', 'youtube.com', 'vimeo.com', 'dailymotion.com'].include?(url_host)
  end

  def audio?
    ['soundcloud.com'].include?(url_host) #|| ['.mp3'].include?(url_extension)
  end

  def image?
    ['.jpg', '.png', '.gif', '.bmp', '.tiff'].include?(url_extension)
  end

  def magnific_type
    if self.video? || self.audio?
      "iframe"
    elsif self.image?
      "image"
    else
      "redirect"
    end
  end

  def facebook_share_link
    params = ENV["FACEBOOK_APP_KEY"] + 
      "&link=#{public_url}" +
      "&name=#{CGI::escape(title)}" +
      "&picture=#{image}" +
      "&redirect_uri=#{public_url}"
    "https://www.facebook.com/dialog/feed?app_id=" + params
  end

  def twitter_share_link
    params = "original_referer=#{CGI::escape(public_url)}" +
    "&text=#{CGI::escape(title)}" +
    "&via=brwnppl" +
    "&url=#{CGI::escape(public_url)}"
    "https://twitter.com/intent/tweet?" + params
  end

  def redirect?
    magnific_type == "redirect"
  end

  def icon
    if content_type == "discussion"
      "fui-bubble"
    elsif self.video?
      "fui-video"
    elsif self.audio?
      "fui-volume"
    elsif self.image?
      "fui-image"
    else
      "fui-exit"
    end
  end

  def url
    return self.public_url if self.is_a?(Discussion)
    super
  end

end

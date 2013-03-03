class User < ActiveRecord::Base

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  attr_accessor :cloudinary_avatar

  has_many :stories, :dependent => :delete_all
  has_many :authentications, :dependent => :delete_all

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", dependent: :destroy, class_name: 'Relationship'

  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

  accepts_nested_attributes_for :authentications

  validates_uniqueness_of :username, :case_sensitive => false
  validates_uniqueness_of :email
  validates_presence_of :username
  validates_length_of :username, :minimum => 4, :maximum => 18
  validates_format_of :username, :with => /^[a-zA-Z.\d]*$/, :message => 'format is invalid, only alphabets and digits are allowed'
  validates_presence_of :email
  validates :bio, :presence => true, :length => { :maximum => 300 }
  validates :account_type, :inclusion => { :in => %w(personal business), :message => 'can either be personal or business'}

  state_machine :state, :initial => :new_user do
    
    after_transition :new_user => :setup_completed do |user, transition|
      if user.video_shared
        @graph = Koala::Facebook::API.new(user.oauth_token)
        @graph.put_connections("me", "links", :link => "http://www.youtube.com/watch?v=ce9jbIvDPu4&feature=youtu.be")
      end
    end

    event :setup_account do
      transition :new_user => :setup_completed
    end

    state :setup_completed do
      validates_presence_of :username
    end

  end

  def can_like_more?(story)
    if self.video_shared 
      story.likes.where(user_id: self.id).count < 2
    else
      story.likes.where(user_id: self.id).count < 1
    end
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def update_avatar(provider, user_hash)
    user_hash = user_hash.with_indifferent_access
    self.avatar = 'https://graph.facebook.com/' + user_hash[:user_info][:id] + '/picture' if provider == 'facebook'
    self.avatar = Twitter.user(user_hash[:user_info][:screen_name]).profile_image_url if provider == 'twitter'
    self.save
    return self
  end

  def facebook?
    self.authentications.map(&:provider).include?("facebook")
  end

  def twitter?
    self.authentications.map(&:provider).include?("twitter")
  end

  def facebook
    authentications.where(:provider => 'facebook').first
  end

end

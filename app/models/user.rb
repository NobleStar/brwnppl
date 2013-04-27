class User < ActiveRecord::Base

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  attr_accessor :cloudinary_avatar, :password_confirmation

  scope :robots, where('email LIKE ?', '%@brwnppl.com')

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
  validates_presence_of :password, :if => Proc.new {|user| !user.facebook? && user.new_record? }
  validates_confirmation_of :password, :if => Proc.new {|user| !user.facebook? && user.password_confirmation.present? }
  validates :account_type, :inclusion => { :in => %w(personal business), :message => 'can either be personal or business'}

  state_machine :state, :initial => :new_user do
    
    after_transition :new_user => :setup_completed do |user, transition|
      if user.video_shared and user.oauth_token.present?
        @graph = Koala::Facebook::API.new(user.oauth_token)
        @graph.put_connections("me", "links", :link => "http://www.youtube.com/watch?v=8V8b4qgGEY0")
      end
    end

    event :setup_account do
      transition :new_user => :setup_completed
    end

    state :new_user do
      validates :bio, :presence => true, :length => { :maximum => 300 }
      validates_presence_of :username
    end

    state :setup_completed do
      
    end

  end

  def can_like_more?(story)
    return true if self.is_admin
    if self.video_shared 
      story.likes.where(user_id: self.id).count < 2
    else
      story.likes.where(user_id: self.id).count < 1
    end
  end

  def can_publish_action_to_facebook?
    if self.facebook?
      @graph = Koala::Facebook::API.new(self.oauth_token)
      permissions = @graph.get_connections('me','permissions')
      permissions[0]['publish_actions']
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
    self.authentications.map {|a| a.provider.to_s }.include?("facebook")
  end

  def twitter?
    self.authentications.map {|a| a.provider.to_s }.include?("twitter")
  end

  def facebook
    authentications.where(:provider => 'facebook').first
  end

end

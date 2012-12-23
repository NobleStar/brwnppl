class User < ActiveRecord::Base

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  attr_accessor :cloudinary_avatar

  has_many :stories, :dependent => :delete_all
  has_many :authentications, :dependent => :delete_all
  accepts_nested_attributes_for :authentications

  validates_uniqueness_of :username
  validates_uniqueness_of :email

  state_machine :state, :initial => :new_user do
    
    event :setup_account do
      transition :new_user => :setup_completed
    end

    state :setup_completed do
      validates_presence_of :username
    end

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

end

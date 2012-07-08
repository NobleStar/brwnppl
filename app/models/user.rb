class User < ActiveRecord::Base

  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  def update_avatar(provider, user_hash)
    user_hash = user_hash.with_indifferent_access
    self.avatar = 'http://graph.facebook.com/' + user_hash[:user_info][:id] + '/picture' if provider == 'facebook'
    self.avatar = Twitter.user(user_hash[:user_info][:screenname]).profile_image_url if provider == 'twitter'
    self.save
    return self
  end

end

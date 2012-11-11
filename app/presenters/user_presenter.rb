class UserPresenter < BasePresenter
  presents :user


  def large_facebook_avatar
    h.image_tag user.avatar + '?type=large', :class => 'profilePhoto'
  end

  def large_twitter_avatar
    h.image_tag user.avatar.gsub('_normal.', '.' ), :class => 'profilePhoto'
  end

  def avatar(size = nil)
    if user.facebook?
      self.send("#{size}_facebook_avatar")
    elsif user.twitter?
      self.send("#{size}_twitter_avatar")
    end
  end
end
module ApplicationHelper

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def user_avatar(user, options = {})
    if user.avatar.present?
      user.avatar
    elsif user.facebook?
      cloudinary_url(user.authentications.first.uid + '.jpg', {:type => :facebook}.merge(options) )
    elsif user.twitter?
      cloudinary_url(user.authentications.first.uid + '.jpg', {:type => :twitter}.merge(options) )
    else
      "http://brwnppl.com/assets/default_user_image.jpg"
    end
  end

  def large_facebook_avatar(user)
    'https://graph.facebook.com/' + user.facebook.uid + '/picture?type=large'
  end

  def already_liked(user, story)
    if user.nil?
      "You need to login to be able to up-vote this story!"
    elsif story.likers.include?(user)
      "You already like this story!"
    else
      "Up-vote this story!"
    end
  end

  def already_downvoted(user, story)
    if user.nil?
      "You need to login to be able to down-vote this story!"
    elsif story.dislikers.include?(user)
      "You already downvoted this story!"
    else
      "Down vote this story"
    end
  end

  def reshare_allowed?(user)
    if user.nil?
      "You need to login to be able to re-share this story!"
    end
  end

  def disqus_sso(user)
    data = { id: user.id, username: user.username, email: user.email, avatar: user.avatar }
    message = Base64.encode64(data.to_json).gsub("\n", "")
    timestamp = Time.now.to_i
    { 
      hmac:      OpenSSL::HMAC.hexdigest('sha1', ENV['DISQUS_SECRET_KEY'], '%s %s' % [message, timestamp]),
      timestamp: timestamp,
      message:   message 
    }
  end
  
end

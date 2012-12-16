module ApplicationHelper

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def user_avatar(user, options = {})
    if user.facebook?
      cloudinary_url(user.authentications.first.uid + '.jpg', {:type => :facebook}.merge(options) )
    elsif user.twitter?
      cloudinary_url(user.authentications.first.uid + '.jpg', {:type => :twitter}.merge(options) )
    else
      user.avatar
    end
  end
  
end

class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :story

  def avatar
    user.avatar
  end
  
end
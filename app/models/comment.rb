class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :story
  validates_presence_of :content

  attr_accessor :socket_id

  before_create :trigger_pusher_notification

  def avatar
    user.avatar
  end

  def name
    user.name
  end

  def trigger_pusher_notification
    Pusher[story.id.to_s].trigger('new-comment', { :name => name, :avatar => self.avatar, :content => self.content }.to_json, socket_id )
  end
  
end
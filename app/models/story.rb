class Story < ActiveRecord::Base

  default_scope :order => 'created_at DESC'
  belongs_to :user
  
  validates_format_of :url, :with => URI::regexp(%w(http https))
  validates_presence_of :url, :title
end

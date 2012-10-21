class Community < ActiveRecord::Base

  include FriendlyId
  friendly_id :name, :use => [:slugged, :history]

end
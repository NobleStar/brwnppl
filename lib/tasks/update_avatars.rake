# require "#{Rails.root}/app/helpers/application_helper"
# require "cloudinary/utils"
# include ApplicationHelper

# namespace :users do
  
#   desc "Update user avatars to use Cloudinary"
#   task :update_avatars => :environment do
#     User.all.each do |user|
#       puts "Updating #{user.username}"
#       #@user.authentications.first.uid
#       puts cloudinary_url(user.authentications.first.uid + '.jpg', {:type => :facebook} )
#     end
#   end

# end


# TO DO TASKS

# 1. Update All Avatars
# 2. Update all Story images to use Default images
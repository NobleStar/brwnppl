namespace :content_types do
  
  desc "Update content type public names"
  task :update_names => :environment do
    web_link = ContentType.find_by_internal_name('web_link')
    web_link.public_name = 'Weblink (links to all other stuff online)'
    web_link.save

    video = ContentType.find_by_internal_name('video')
    video.public_name = 'Video (links to video players like YouTube, Vimeo, etc)'
    video.save

    image = ContentType.find_by_internal_name('image')
    image.public_name = 'Image (links to images like .jpg, .gif .png)'
    image.save

    audio = ContentType.find_by_internal_name('audio')
    audio.public_name = 'Audio (links to audio players like Soundcloud, Bandcamp, etc)'
    audio.save
  end

end
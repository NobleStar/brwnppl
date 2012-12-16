class WebLink < Story
  validates_format_of :url, :with => URI::regexp(%w(http https))
  validates_presence_of :url
end
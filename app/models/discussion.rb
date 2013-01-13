class Discussion < Story
  validates :title, :length => { :maximum => 500 } 
  before_create :clean_attributes

  def clean_attributes
    # a discussion usually doesn't have a URL
    # we move the textbox url value to title
    self.title = self.url
    self.send(:set_slug)
    self.url = nil

    # if an image is attached with a discussion
    # we copy over the image link to url
    self.url = self.image if self.image
  end

end
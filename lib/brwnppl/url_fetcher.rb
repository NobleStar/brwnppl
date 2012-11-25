class Brwnppl::UrlFetcher

  def initialize(url, story_type=nil)
    @url = url
    @story_type = story_type

    if invalid_url?
      @story_data = { title: 'Invalid URL' }
    elsif open_graph_url?
      @story_data.decorate_preview
    elsif image_file_link?
      @story_data = { title: 'Give your image a custom title!', image: @url}
    else
      page = Nokogiri::HTML( HTTParty.get(url, :headers => {"User-Agent" => 'Mozilla/5.0'}) )
      @story_data = { title: page.title }
    end

    @story_data
  end

  def open_graph_url?
    @story_data = OpenGraph.fetch(@url)
  end

  def to_json
    @story_data.to_json
  end

  def image_file_link?
    ['.png', '.gif', '.jpg'].include? @url[-4..-1]
  end

  def invalid_url?
    begin
      link = URI.parse(@url)
      return false if %w(http https).include?(link.scheme)
    rescue
      return true
    end
  end
    
end


# Monkey patching a new method to OpenGraph
class OpenGraph::Object

  PREVIEW_NAMESPACE = 'Brwnppl::Preview::'

  # just drop in a class for each site with it's name downcased
  # in the brwnppl/preview directory
  # Each of this class should implement a #html method
  # which should output the html responsible to be shown on preview and story view

  # The html method in these adapter classes such as youtube.rb, metacafe.rb 
  # should present back the HTML required to construct the preview

  # use #reconstruct_embed(url) method to extract, manipulate or reconstruct the embed urls
  # in case these URL's are different from the Video link.
  # This method in all cases should only manipulate or extract resource id's from the URL.

  def decorate_preview
    preview_class = PREVIEW_NAMESPACE + self.site_name.downcase.classify
    # rescue for cases where we might not support the remote site preview decoration
    begin
      self[:html] = preview_class.constantize.new.send(:html, self)
    rescue
      self[:html] = nil
    end
  end

end
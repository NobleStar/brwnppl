class Disqus

  API_VERSION = "3.0"
  FORUM = "brwnppl"
  API_KEY = ENV['DISQUS_PUBLIC_KEY']
  BASE_URI = "https://disqus.com/api/#{API_VERSION}"

  def endpoint
    URI("#{BASE_URI}/threads/details.json?forum=#{FORUM}&thread:link=#{@story.public_url}&api_key=#{API_KEY}")
  end

  def sync_comment_count(story)
    @story = story
    client = prepare_client(endpoint)
    res = client.get(endpoint.request_uri)
    comments_count = JSON.parse(res.body)['response']['posts']
    @story.update_attributes({ comments_count: comments_count })
  end
  handle_asynchronously :sync_comment_count

  def prepare_client(uri)
    client = Net::HTTP.new(uri.host, uri.port)
    client.use_ssl = true
    client.verify_mode = OpenSSL::SSL::VERIFY_NONE
    client
  end

end
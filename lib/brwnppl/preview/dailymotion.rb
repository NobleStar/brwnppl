class Brwnppl::Preview::Dailymotion

  def html(graph_object)
    dailymotion_url = reconstruct_embed(graph_object.url)
    "<iframe frameborder='0' width='480' height='270' src='#{dailymotion_url}'></iframe>"
  end

  def reconstruct_embed(url)
    video_id = url.split(/_.+/)[0].split("/").last
    "http://dailymotion.com/embed/video/#{video_id}"
  end

end
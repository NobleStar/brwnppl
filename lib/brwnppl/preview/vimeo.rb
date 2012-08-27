class Brwnppl::Preview::Vimeo

  def html(graph_object)
    vimeo_url = reconstruct_embed(graph_object.url)
    "<iframe src='#{vimeo_url}' width='500' height='281' frameborder='0' webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>"
  end

  def reconstruct_embed(url)
    video_id = url.split('/').last
    "http://player.vimeo.com/video/#{video_id}"
  end

end
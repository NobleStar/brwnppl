class Brwnppl::Preview::Metacafe

  def html(graph_object)
    metacafe_url = reconstruct_embed(graph_object.url)
    "<embed flashVars='playerVars=autoPlay=no' src='#{metacafe_url}' width='530' height='300' wmode='transparent' allowFullScreen='true' allowScriptAccess='always' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash'></embed>" 
  end

  def reconstruct_embed(url)
    extracted_url = url.split('/')
    video_id = extracted_url[-2]
    video_title = extracted_url[-1]
    "http://metacafe.com/fplayer/#{video_id}/#{video_title}.swf"
  end

end
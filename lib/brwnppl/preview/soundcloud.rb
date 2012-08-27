class Brwnppl::Preview::Soundcloud

  def html(graph_object)
    "<iframe width='530' height='80' scrolling='no' frameborder='no' src='#{graph_object.video}'></iframe>"
  end

end

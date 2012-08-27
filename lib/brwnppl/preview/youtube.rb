class Brwnppl::Preview::Youtube

  def html(graph_object)
    "<iframe width='530' height='300' src='#{graph_object.video}' frameborder='0' allowfullscreen></iframe>"
  end

end
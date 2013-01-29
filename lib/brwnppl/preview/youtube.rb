class Brwnppl::Preview::Youtube

  def html(graph_object)
    "<iframe width='530' height='300' src='#{graph_object.video}&fs=1' frameborder='0' allowfullscreen webkitallowfullscreen mozallowfullscreen></iframe>"
  end

end
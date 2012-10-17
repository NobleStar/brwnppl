window.Brwnppl =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Brwnppl.Routers.RootRouter()
    Backbone.history.start()

$(document).ready ->
  Brwnppl.init()

  # Fix for #_=_ problem after Facebook Sign In
  if window.location.hash.search('#_') >= 0
    window.location.hash = ''

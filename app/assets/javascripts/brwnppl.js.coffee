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

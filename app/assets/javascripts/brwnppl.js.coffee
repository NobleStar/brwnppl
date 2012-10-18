window.Brwnppl =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  geoLocationFound: (position)->
    new Brwnppl.Models.Location(position)
  init: ->
    new Brwnppl.Routers.RootRouter()
    Backbone.history.start({pushState: true})

$(document).ready ->
  Brwnppl.init()

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition( Brwnppl.geoLocationFound, null )
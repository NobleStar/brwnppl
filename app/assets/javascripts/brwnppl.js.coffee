window.Brwnppl =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  geoLocationFound: (position)->
    new Brwnppl.Models.Location(position)
  init: ->
    new Brwnppl.Routers.RootRouter()
    Backbone.history.start()

$(document).ready ->
  Brwnppl.init()

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition( Brwnppl.geoLocationFound, null )

  $('a#communities').toggle(
    ->
      $('.background').animate { height: 310}, 500
      
      $('.backgroundContainer').animate { height: 310 }, 500, ->
          $(@).find('.communities').removeClass('hidden')

    ->
      $('.background').animate { height: 69}, 500
      
      $('.backgroundContainer').animate { height: 71 }, 500, ->
          $(@).find('.communities').addClass('hidden')
  )
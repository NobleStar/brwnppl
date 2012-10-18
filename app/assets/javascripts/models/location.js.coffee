class Brwnppl.Models.Location extends Backbone.Model

  initialize: (position) ->
    window.sessionUser.set({'latitude': position.coords.latitude})
    window.sessionUser.set({'longitude': position.coords.longitude})
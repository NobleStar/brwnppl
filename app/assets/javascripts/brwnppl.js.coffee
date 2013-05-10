window.Brwnppl =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    window.router = new Brwnppl.Routers.RootRouter();
    Backbone.history.start({pushState: true});

$(document).ready ->
  Brwnppl.initialize()

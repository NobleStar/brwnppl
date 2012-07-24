class Brwnppl.Models.Sharer extends Backbone.Model

  url: ->
    '/api/url_fetcher/?url=' + @.path
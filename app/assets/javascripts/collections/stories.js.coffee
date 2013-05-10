class Brwnppl.Collections.Stories extends Backbone.Collection

  initialize: (models, options)->
    @sort = options.sort

  url: ->
    "/api/stories/" + @sort

  model: Brwnppl.Models.Story
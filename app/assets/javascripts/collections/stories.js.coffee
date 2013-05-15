class Brwnppl.Collections.Stories extends Backbone.Collection

  initialize: (models, options)->
    @sort = options.sort
    @time = options.time

  url: ->
    "/api/stories/" + @sort + "?time=" + @time

  model: Brwnppl.Models.Story
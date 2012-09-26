class Brwnppl.Models.Comment extends Backbone.Model

  url: ->
    'api/stories/' + @story_id + '/comments'
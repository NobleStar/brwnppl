class Brwnppl.Models.User extends Backbone.Model

  url: ->
    '/api/users/' + @.id
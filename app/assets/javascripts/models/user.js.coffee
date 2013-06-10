class Brwnppl.Models.User extends Backbone.Model

  initialize: ->
    @url = '/api/users/' + @get('username')
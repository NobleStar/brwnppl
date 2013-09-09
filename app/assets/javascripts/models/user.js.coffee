class Brwnppl.Models.User extends Backbone.Model

  initialize: ->
    @url = '/api/users/' + @get('username')

  follow: (viewScope) ->
  	$.get( "/api/users/#{@get('username')}/follow.json" )
      .done(viewScope.showUnfollowButton())

  unfollow: (viewScope) ->
    $.get( "/api/users/#{@get('username')}/unfollow.json" )
      .done(viewScope.showFollowButton()())
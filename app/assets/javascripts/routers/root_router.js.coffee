class Brwnppl.Routers.RootRouter extends Backbone.Router
  
  routes: 
    ''                : 'index'
    'me'              : 'dashboard'
    ':user_handle'    : 'user_profile'

  index: ->
    @stories = new Brwnppl.Collections.Stories()
    @stories.fetch()

    stories = new Brwnppl.Views.StoryIndex(collection: @stories)
    sharer  = new Brwnppl.Views.Sharer()

    $('.shareSection').html(sharer.render().el)
    $('.ribbon').html(stories.render().el)
    
  dashboard: ->
    alert 'space for dashboard'

  user_profile: (handle) ->
    user = new Brwnppl.Models.User()
    user.id = handle
    view = new Brwnppl.Views.UserProfile({model: user})
    user.fetch()
    $('.ribbon').html(view.render().el)

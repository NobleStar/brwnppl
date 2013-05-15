class Brwnppl.Routers.RootRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    ''                 : 'index'
    'login'            : 'login'
    ':username'        : 'userProfile'
    'browse/:sort_by'  : 'index'
    'story/:slug'      : 'storyViewer'

  index: (sort_by) ->
    sort_by ||= 'popular'
    @stories = new Brwnppl.Collections.Stories([], { sort: sort_by, time: 'all' })
    @stories.fetch({
      success: (collection, response, options)->
        @storiesView.remove() if @storiesView
        @storiesView = new Brwnppl.Views.StoriesView({collection: collection})
        @storiesView.renderAll()
    },
      error: ->
        console.log 'failed to fetch stories'
    )

  storyViewer: (slug) ->
    console.log(@stories)
    console.log 'load story viewer for ' + slug

  login: ->
    @loginView = new Brwnppl.Views.LoginView()
    @loginView.render()

  userProfile: (username) ->
    @userProfile = new Brwnppl.Views.UserProfile()
    @userProfile.render()


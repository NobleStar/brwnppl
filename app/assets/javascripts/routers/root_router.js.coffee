class Brwnppl.Routers.RootRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    ''                       : 'index'
    'browse/:sort_by'        : 'index'
    'browse/:sort_by/:page'  : 'index'
    'b/:community/:sort_by'       : 'communityStories'
    'b/:community/:sort_by/:page' : 'communityStories'
    'login'                  : 'login'
    'add_story'              : 'addStory'
    ':username'              : 'userProfile'
    'story/:slug'            : 'storyViewer'

  index: (sort_by, page) ->
    sort_by ||= 'popular'
    page ||= 1
    $('title').text("Brwnppl | " + _.str.capitalize(sort_by) )
    @stories = new Brwnppl.Collections.Stories([], { sort: sort_by, time: 'all', page: page})
    @stories.renderView()

  communityStories: (community, sort_by, page) ->
    page ||= 1
    sort_by ||= 'top'
    $('title').text("Brwnppl | " + _.str.humanize(community) )
    @stories = new Brwnppl.Collections.Stories([], { sort: 'community', time: 'all', page: page, slug: community})
    @stories.renderView()

  addStory: ->
    console.log 'will add story'

  storyViewer: (slug) ->
    console.log slug

  login: ->
    @loginView = new Brwnppl.Views.LoginView()
    @loginView.render()

  userProfile: (username) ->
    if username == '_=_'
      @index()
    profile = new Brwnppl.Views.UserProfile({ username: username })
    profile.render()


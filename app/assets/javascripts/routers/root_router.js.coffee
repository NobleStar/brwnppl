class Brwnppl.Routers.RootRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    ''        : 'index'
    'recent'  : 'recent'
    'latest'  : 'latest'

  index: ->
    @stories = new Brwnppl.Collections.Stories([], { sort: 'popular' })
    @stories.fetch({
      success: (collection, response, options)->
        storiesView = new Brwnppl.Views.StoriesView({collection: collection})
        storiesView.renderAll()
    },
      error: ->
        console.log 'failed to fetch stories'
    )

  recent: ->
    @stories = new Brwnppl.Collections.Stories([], { sort: 'recent' })
    @stories.fetch({
      success: (collection, response, options)->
        storiesView = new Brwnppl.Views.StoriesView({collection: collection})
        storiesView.renderAll()
    },
      error: ->
        console.log 'failed to fetch stories'
    )

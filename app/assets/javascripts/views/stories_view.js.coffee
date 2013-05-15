class Brwnppl.Views.StoriesView extends Backbone.View

  el: '#app-root'

  events: 
    'click .link': 'interceptStoryView'

  interceptStoryView: (event)->
    classList = event.target.classList
    redirect = _.contains classList, "mfp-redirect"
    if redirect
      sourceUrl = $(event.target).data('mfp-source')
      window.location.assign(sourceUrl)

  remove: ->
    $(@el).empty()

  renderAll: ->
    _.each(
      @collection.models
      (story) ->
        storyView = new Brwnppl.Views.StoryView(story)
        $(@el).append( story.render().html() )
      this
      )

    @enableMagnific()

  enableMagnific: ->
    Magnific.initialize();

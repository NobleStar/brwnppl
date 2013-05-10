class Brwnppl.Views.StoriesView extends Backbone.View

  el: '#app-root'

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
    $('.link').magnificPopup({
      image: {
        verticalFit: true
      }
    })

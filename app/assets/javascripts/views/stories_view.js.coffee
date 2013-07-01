class Brwnppl.Views.StoriesView extends Backbone.View

  el: '#app-root'

  events: 
    'click .link': 'interceptStoryView'
    'click .thumbnail': 'interceptStoryView'

  interceptStoryView: (event)->
    classList = event.target.classList
    redirect = _.contains classList, "mfp-redirect"
    if redirect
      sourceUrl = $(event.target).attr('href')
      window.location.assign(sourceUrl)

  close: ->
    @$el.empty()
    @unbind()
    @paginationView.close()

  renderAll: ->
    stories = @collection.map( (story) ->
      storyView = new Brwnppl.Views.StoryView(story)
      html = storyView.render().html()
      story.on('remove', storyView.close, this)
      return html
    , this)
    $(@el).html(stories)
    @enableMagnific()
    @enableTooltips()

  enableTooltips: ->
    $("[data-toggle=tooltip]").tooltip("show");

  enableMagnific: ->
    Magnific.initialize();

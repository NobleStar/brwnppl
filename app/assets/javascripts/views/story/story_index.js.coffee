class Brwnppl.Views.StoryIndex extends Backbone.View
  
  template: JST['story/index']

  className: 'posts'

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(stories: @collection))
    this
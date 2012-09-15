class Brwnppl.Views.StoryIndex extends Backbone.View
  
  template: JST['story/index']

  className: 'posts'

  initialize: ->
    @collection.on('reset', @render, this)

  events:
    'click .like-button'     :   'likeStory'
    'click .postContent h2'  :   'launchViewer'

  getStoryId: (event_obj) ->
    $(event_obj.currentTarget).closest('.postContent').data('story-id')

  likeStory: (event) ->
    event.preventDefault()
    story_id = @.getStoryId(event)
    story = @.collection.get(story_id)
    story.likeStory( $(event.currentTarget) )

  launchViewer: (event) ->
    event.preventDefault()
    story_id = @.getStoryId(event)
    story = @.collection.get(story_id)
    debugger

  render: ->
    $(@el).html(@template(stories: @collection))
    this
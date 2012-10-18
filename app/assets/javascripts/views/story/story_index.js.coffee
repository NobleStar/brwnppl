class Brwnppl.Views.StoryIndex extends Backbone.View
  
  template: JST['story/index']

  className: 'posts'

  initialize: ->
    @collection.on('reset', @render, this)

  events:
    'click .like-button'     :   'likeStory'
    'click .comments'        :   'launchViewer'
    'click .postContent h2'  :   'launchViewer'

  getStoryId: (event_obj) ->
    $(event_obj.currentTarget).closest('.postContent').data('story-id')

  likeStory: (event) ->
    if window.sessionUser.get('id')
      event.preventDefault()
      story_id = @.getStoryId(event)
      story = @.collection.get(story_id)
      story.likeStory( $(event.currentTarget) )
    else
      console.warn "User not signed in but tried liking Story."

  launchViewer: (event) ->
    event.preventDefault()
    story_id = @.getStoryId(event)
    story = @.collection.get(story_id)
    story_viewer = new Brwnppl.Views.StoryViewer({ model: story })
    # $('#storyViewer').html(story_viewer.render().el);

  render: ->
    $(@el).html(@template(stories: @collection))
    this
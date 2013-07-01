class Brwnppl.Models.Story extends Backbone.Model
  
  urlRoot: '/api/stories'

  render: ->
    storyView = new Brwnppl.Views.StoryView(@)
    storyView.render()

  likeStory: (viewScope) ->
    $.post('/api/likes', { story_id: @.get('id') })
    .done(viewScope.anonLike())
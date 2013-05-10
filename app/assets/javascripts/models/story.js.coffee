class Brwnppl.Models.Story extends Backbone.Model
  
  urlRoot: '/api/stories'

  render: ->
    storyView = new Brwnppl.Views.StoryView(@)
    storyView.render()
class App.Stories extends Spine.Controller

  constructor: ->
    super
    @log('Instantiating App.Stories Controller')
    App.StoryModel.bind 'refresh', @renderAll
    App.StoryModel.fetch()

  renderAll: ->
    console.log('Rendering the main stories')
    App.StoryModel.all()
    App.StoryModel.each (story) -> new App.Story(story: story)
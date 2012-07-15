class App.Story extends Spine.Controller
  
  constructor: ->
    super
    throw "@story required" unless @story
    @story.bind 'refresh change', @render()
  
  render: ->
    story = @story
    debugger
    @html( @view('stories/story') )
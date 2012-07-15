class App.Sharer extends Spine.Controller
  
  render: =>
    @log('starting to render the sharer')
    @html @view('sharer/index')()

  constructor: ->
    super
    @log('Instantiating Sharer Controller')
    @render()
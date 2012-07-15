#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

class App extends Spine.Controller

  constructor: ->
    super
    @log("Booting Brwnppl.....")

    @append(
      sharer  = new App.Sharer( el : $('.shareSection'))
      stories = new App.Stories(el : $('.ribbon'))
      )
    
    App.StoryModel.one 'refresh', ->
      Spine.Route.setup( history: true )


window.App = App
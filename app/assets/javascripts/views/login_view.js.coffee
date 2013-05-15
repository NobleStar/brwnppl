class Brwnppl.Views.LoginView extends Backbone.View
  el: '#app-root'

  render: ->
    source = $('#login-view').html()
    template = Handlebars.compile(source)
    $(@el).html( template() )

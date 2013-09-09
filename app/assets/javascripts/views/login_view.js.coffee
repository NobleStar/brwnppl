class Brwnppl.Views.LoginView extends Backbone.View
  el: '#app-root'

  events: 
  	'click #login': 'login'

  render: ->
    source = $('#login-view').html()
    template = Handlebars.compile(source)
    $(@el).html( template() )

  login: (event) ->
  	debugger	
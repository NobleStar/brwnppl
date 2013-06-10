class Brwnppl.Views.UserProfile extends Backbone.View

  el: '#app-root'

  initialize: (options)->
    @model = new Brwnppl.Models.User({ username: options.username })
    @model.on('change', @render, this)
    @model.fetch()

  render: ->
    source = $('#user-profile').html()
    template = Handlebars.compile(source)
    $('.pagination').empty()
    $(@el).empty()
    $(@el).append( template({user: @model.attributes }) )
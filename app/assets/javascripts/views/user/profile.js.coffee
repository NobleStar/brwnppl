class Brwnppl.Views.UserProfile extends Backbone.View
  
  template: JST['user/profile']

  initialize: ->
    @model.on('change', @render, this)

  render: ->
    $(@el).html(@template(user: @model))
    this
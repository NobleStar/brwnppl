class Brwnppl.Views.UserProfile extends Backbone.View
  
  template: JST['user/profile']

  initialize: ->
    @model.on('change', @render, this)

  render: ->
    $('title').html("#{@model.get('name')} on Brwnppl")
    $(@el).html(@template(user: @model))
    this
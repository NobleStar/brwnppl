class Brwnppl.Views.Notifications extends Backbone.View

	template: JST['notification/popup']

	render: ->
    $('body').css('overflow', 'hidden')
    $(@el).html(@template(notification: @model))
    this

  events:
  	'click .notificationClose'	: 	'closeNotificationDialog'

  closeNotificationDialog: ->
    $('body').css('overflow', 'scroll')
    $(@el).hide()
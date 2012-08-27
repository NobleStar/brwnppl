class Brwnppl.Views.Notifications extends Backbone.View

	template: JST['notification/popup']

	render: ->
    $(@el).html(@template(notification: @model))
    this

  events:
  	'click .notificationClose'	: 	'closeNotificationDialog'


  closeNotificationDialog: ->
  	$(@el).hide()

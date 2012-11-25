class Brwnppl.Notification
  
  display: ->
    @fader.show()
    @box.show()

  constructor: (header, messages) ->
    @render(header, messages)
    @box = $('.notificationBox')
    @fader = $('.fader')
    @bindCloseEvent()

  render: (header, messages) ->
    data = { header: header, messages: messages }
    source = $('#notification_template').html()
    template = Handlebars.compile(source)
    $('body').prepend(template(data))

  close: ->
    @fader.remove()
    @box.remove()

  bindCloseEvent: ->
    @box.find('.notificationClose').bind 'click', { controller: this },  (event) ->
      c = event.data.controller
      c.close()
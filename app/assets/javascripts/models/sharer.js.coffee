class Brwnppl.Models.Sharer extends Backbone.Model

  url: ->
    '/api/url_fetcher/?url=' + @.path

  validate: (attrs) ->
    urlregex = new RegExp("^(http|https|ftp)\://([a-zA-Z0-9\.\-]+(\:[a-zA-Z0-9\.&amp;%\$\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|([a-zA-Z0-9\-]+\.)*[a-zA-Z0-9\-]+\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\:[0-9]+)*(/($|[a-zA-Z0-9\.\,\?\'\\\+&amp;%\$#\=~_\-]+))*$")
    unless urlregex.test(attrs.path)
      return "Invalid URL"

  loadElementsOnShareForm: ->
    if @.get('title')
      $('textarea.linkBar').val(@.get('title'))
      if @.get('html')
        @.populatePreviewHTML(@.get('html'))
        @.populatePreviewImage(@.get('image'), false)
      else if @.get('image')
        @.populatePreviewImage(@.get('image'), true)
    else
      $('textarea.linkBar').val('Unable to grab a title from the given link!')


  populatePreviewHTML: (html) ->
    $('#shareForm #preview').html(html)

  populatePreviewImage: (image, show = false) ->
    $('img#linkBarImage').attr('src', image)
    $('input#story_image').val(image)
    $('img#linkBarImage').show() if show

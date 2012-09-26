class Brwnppl.Models.Sharer extends Backbone.Model

  url: ->
    '/api/url_fetcher/?url=' + @.path

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

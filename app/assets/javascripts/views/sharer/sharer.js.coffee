class Brwnppl.Views.Sharer extends Backbone.View
  
  template: JST['sharer/index']

  initialize: ->
    @stories = @.options.stories
    @model.on('change', @render, this)
    @stories.on('add', @addStoryToHome, this)
  
  events:
    'keyup input.linkBar'    :  'fetch_link_details'
    'click #shareThis'       :  'share_link'
    'click .icon'            :  'toggleStoryType'

  
  render: ->
    $(@el).html(@template(user: @model))
    this

  
  fetch_link_details: ->
    url = new Brwnppl.Models.Sharer()
    if url.set({ path: $('input.linkBar').val() })
      url.path = url.get('path')
      $('.loader').show()
      $('textarea.linkBar').show()
      url.fetch
        error: ->
          $('textarea.linkBar').val('Error fetching the URL or Invalid URL')
          $('.loader').hide()
        success: ->
          $('.loader').hide()
          if url.get('title')
            $('textarea.linkBar').val(url.get('title'))
            if url.get('image')
              $('img#linkBarImage').attr('src', url.get('image'))
              $('img#linkBarImage').show()
          else
            $('textarea.linkBar').val('Unable to grab a title from the given link!')

  
  share_link: (event) ->
    debugger
    event.preventDefault()
    link = $('input.linkBar').val()
    title = $('textarea.linkBar').val()
    @stories.create({ title: title, url: link},
      {
        wait: true
        error: (model, response) =>
          errors = JSON.parse(response.responseText).errors
          error_messages = _.map errors, (error) ->
            "<p>#{error}</p>"
          @error("Unable to post this story: #{error_messages}")
        success: =>
          @success('Successfully Posted your Story!')
          @clearShareForm()
      }
    )

  addStoryToHome: ->
    alert('story need to be added to the home page or no? if yes, this call back need to tackle that')

  toggleStoryType: (event) ->
    $('.icon').removeClass('selected')
    storyTypeSelector = $(event.target)
    storyTypeSelector.addClass('selected')
    storyType = storyTypeSelector.data('type')
    $('#story_type').val(storyType)

  success: (message) ->
    $success = $('#success')
    $success.html('')
    $success.append('<p>'+message+'</p>')
    $success.slideToggle 'fast', ->
      $success.delay(3000).fadeOut('slow');

  error: (message) ->
    $alert = $('#alert')
    $alert.html('')
    $alert.append('<p>'+message+'</p>')
    $alert.slideToggle 'fast', ->
      $alert.delay(3000).fadeOut('slow');

  clearShareForm: ->
    $('.linkBar').val("")
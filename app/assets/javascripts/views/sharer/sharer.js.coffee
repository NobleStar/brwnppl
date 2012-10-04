class Brwnppl.Views.Sharer extends Backbone.View
  
  template: JST['sharer/index']

  initialize: ->
    @stories = @.options.stories
    @model.on('change', @render, this)
    @stories.on('add', @addStoryToHome, this)
  
  events:
    'keyup input.linkBar'    :  'fetch_link_details'
    'paste input.linkBar'    :  'fetch_link_details'
    'click #shareThis'       :  'share_link'
    'submit #shareForm'      :  'share_link'

  
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
        success: (model, response) ->
          $('.loader').hide()
          model.loadElementsOnShareForm(url)

  
  share_link: (event) ->
    event.preventDefault()
    link  = $('input.linkBar').val()
    title = $('textarea.linkBar').val()
    image = $('input#story_image').val()
    # type  = $('input#story_type').val()
    @stories.create({ title: title, url: link, image: image },
      {
        error: (model, response) =>
          notification = {}
          notification.messages = JSON.parse(response.responseText).errors
          notification.header = "Error!!"
          error = new Brwnppl.Views.Notifications({ model: notification })
          $('#notifications').html(error.render().el)
        success: (model, response) =>
          notification = {}
          notification.header = "You are awesome!!"
          notification.messages = ['Thanks for sharing that awesome story with the community!! Wanna share some more?']
          success = new Brwnppl.Views.Notifications({ model: notification })
          @.clearShareForm()
          $('#notifications').html(success.render().el)
      }
    )

  addStoryToHome: ->
    # alert('story need to be added to the home page or no? if yes, this call back need to tackle that')

  renderStoryViewer: ->
    

  clearShareForm: ->
    $('form#shareForm').find(':input').val('').removeAttr('checked').removeAttr('selected')
    $('form#shareForm textarea').val('').hide()
    $('form#shareForm #preview').html('')
    $('form#shareForm #linkBarImage').remove()
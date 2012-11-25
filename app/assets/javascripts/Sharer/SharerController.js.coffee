class SharerController

  init: ->
    @dom = $('#content .shareSection')
    source = $('#sharer_template').html()
    template = Handlebars.compile(source)
    @dom.html(template())
    
  event_bindings: ->
    @url_field().bind 'input propertyChange', {controller: @}, @fetch_link_details
    @share_button().bind 'click', {controller: @}, @post_story

  post_story: (e) ->
    e.preventDefault()
    c = e.data.controller
    title = c.story_title().val()
    link  = c.url_field().val()
    image = c.story_image_input().val()
    community = c.communities_menu().val()

    $.ajax
        url      :  '/api/stories'
        type     :  'POST'
        dataType :  'json'
        data     :  { story: { title: title, url: link, image: image, community_id: community } }
        complete :  (data, status) =>
          response = JSON.parse(data.responseText)
          notification = new Brwnppl.Notification(response.header, response.messages)
          notification.display()
          if response.saved
            c.resetSharer()

  fetch_link_details: (e) ->
    c = e.data.controller
    if @value.length >= 1
      c.loader().show()

      $.ajax 
        url      :  '/api/url_fetcher'
        type     :  'GET'
        dataType :  'json'
        data     :  { url: @value }
        complete :  (data, status) ->
          c.urlStory(data, status, c)
        error    :  c.postDiscussionStory

  urlStory: (data, status, c) ->
    console.dir data
    if status is "success"
      c.populate_sharer(data)

      c.story_title().show()
      c.communities_menu().show()
      c.loader().hide()

  populate_sharer: (data) ->
    json = $.parseJSON(data.responseText)
    @populate_story_title(json.title)
    if json.html
      @populate_html(json.html)
    else if json.image
      @populate_image(json.image)

  resetSharer: ->
    @init()
    @event_bindings()

  populate_image: (image) ->
    @image_preview().attr('src', image)
    @story_image_input().val(image)
    @image_preview().show()

  populate_html: (html) ->
    @html_preview().html(html)

  populate_story_title: (title) ->
    @story_title().val(title)


  # HTML Elements
  url_field: ->
    @dom.find('input.linkBar')

  loader: ->
    @dom.find('.loader')

  communities_menu: ->
    @dom.find('select#community')

  story_title: ->
    @dom.find('textarea.linkBar')

  html_preview: ->
    @dom.find('#preview')

  image_preview: ->
    @dom.find('#linkBarImage')

  story_image_input: ->
    @dom.find('#story_image')

  share_button: ->
    @dom.find('#shareThis')



sharer = new SharerController()
sharer.init()
sharer.event_bindings()
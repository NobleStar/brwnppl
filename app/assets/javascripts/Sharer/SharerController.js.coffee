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
    story_type = c.story_type().val()
    content_type = c.content_type().val()

    $.ajax
      url      :  '/api/stories'
      type     :  'POST'
      dataType :  'json'
      data     :  { story: { title: title, url: link, image: image, community_id: community, type: story_type, content_type: content_type } }
      complete :  (data, status) =>
        response = JSON.parse(data.responseText)
        notification = new Brwnppl.Notification(response.header, response.messages)
        notification.display()
        if response.saved
          c.resetSharer()

  fetch_link_details: (e) ->
    c = e.data.controller
    if @value.length >= 1 and c.isUrl( @value )
      c.content_type().children('option[value=discussion]').remove()
      c.loader().show()
      c.story_type().val('WebLink')
      $.ajax 
        url      :  '/api/url_fetcher'
        type     :  'GET'
        dataType :  'json'
        data     :  { url: @value }
        complete :  (data, status) ->
          c.urlStory(data, status, c)
        error    :  c.postDiscussionStory
    else if !c.isUrl( @value )
      c.story_type().val('Discussion')
      c.communities_menu().show()
      c.content_type().val('discussion')

  urlStory: (data, status, c) ->
    console.dir data
    if status is "success"
      c.populate_sharer(data)
      c.story_title().show()
      c.communities_menu().show()
      c.content_type().show()
      c.loader().hide()

  populate_sharer: (data) ->
    json = $.parseJSON(data.responseText)
    @populate_story_title(json.title)
    if json.html and json.image
      @populate_html(json.html)
      @story_image_input().val(json.image)
    else if json.html
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

  isUrl: (link) ->
    if ( /^([a-z]([a-z]|\d|\+|-|\.)*):(\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?((\[(|(v[\da-f]{1,}\.(([a-z]|\d|-|\.|_|~)|[!\$&'\(\)\*\+,;=]|:)+))\])|((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=])*)(:\d*)?)(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*|(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)|((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)|((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)){0})(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(link) )
      return true
    else
      return false

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

  story_type: ->
    @dom.find('input#story_type')

  content_type: ->
    @dom.find('select#content_type_dropdown')


sharer = new SharerController()
sharer.init()
sharer.event_bindings()
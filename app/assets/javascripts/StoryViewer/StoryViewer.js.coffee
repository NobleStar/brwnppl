class Brwnppl.StoryViewer

  constructor: (story_id) ->
    @story_id = story_id
    @current_user = new Brwnppl.User()

  init: ->
    @fetch_story()

  fetch_story: ->
    $.ajax
      url      :  @story_url()
      type     :  'GET'
      dataType :  'json'
      complete :  (data, status) =>
        @story = JSON.parse(data.responseText)
        @comments = @story.comments
        @fetch_story_html(@story, @comments)

  fetch_story_html: (story, comments) ->
    $.ajax
      url      :   '/api/url_fetcher'
      type     :   'GET'
      dataType :   'json'
      data     :   { url : story.url, type: story.content_type, slug: story.slug }
      complete :   (data, status) =>
        response = JSON.parse(data.responseText)
        story.html = response.html
        if story.content_type == 'web_link'
          window.location.href = '/v/' + @story.slug
        else if story.content_type == "image" or story.content_type == "video" or story.content_type == "audio" or story.content_type == "discussion"
          data = { story: story, comments: comments, user: @current_user }
          story.discussion = true if story.content_type == "discussion"
          @render(data)
          @setStoryViewer() if story.content_type == "discussion"
          @bind_events()
          @bind_pusher()
        else
          window.location.href = '/v/' + @story.slug

  postComment: (comment_text) ->
    return false if !comment_text?
    @loader().show()
    $.ajax
      url       :   @comments_url(@story_id)
      type      :   'POST'
      dataType  :   'json'
      data      :   { content: comment_text, socket_id: @pusher.connection.socket_id }
      complete  :   (data, status) =>
        @loader().hide()
        @textarea().val('')
        comment = JSON.parse(data.responseText)
        @append_new_comment(comment)

  setStoryViewer: ->
    prevWidth = @storyWindow().width()
    @storyContent().addClass('hidden')
    @storyComments().width(prevWidth - 40)
    @comments_dom().width(prevWidth - 100)
    @comments_dom().jScrollPane()

  render: (data)->
    source = $('#story_viewer_template').html()
    template = Handlebars.compile(source)
    $('#wrapper').prepend(template(data))

    @bindKeypressEvents()
    
    $('.storyViewer .column').equalHeights( $(window).height() * 0.70, $(window).height() * 0.75)

    content = $('.storyContent').children().eq(1)
    #content.attr('height', '70%') if content.prop('tagName') != 'IFRAME'

    storyHeight = $('.storyWindow').height()
    contentHeight = content.height()
    topPad = (storyHeight - contentHeight)/2 - 30
    content.css('padding-top', topPad)
    @comments_dom().css('height', storyHeight * 0.75)
    @comments_dom().jScrollPane()

  bindKeypressEvents: ->
    keypress.reset()
    keypress.combo "left", =>
      keypress.reset()
      prevStory = $('.post[data-story-id=' + @story_id + ']').prevUntil('.post:first', ':not(.post[data-content-type=web_link])').first()
      if prevStory.size() > 0
        story = new Brwnppl.StoryViewer(prevStory.data('story-id'))
        @storyViewer().remove()
        story.init()

    keypress.combo "right", =>
      keypress.reset()
      nextStory = $('.post[data-story-id=' + @story_id + ']').nextUntil('.post:last', ':not(.post[data-content-type=web_link])').first()
      if nextStory.size() > 0
        story = new Brwnppl.StoryViewer(nextStory.data('story-id'))
        @storyViewer().remove()
        story.init()

  bind_pusher: ->
    @pusher = new Brwnppl.PushService().pusher
    channel = @pusher.subscribe(@story_id.toString())
    channel.bind 'new-comment', (data) =>
      res = JSON.stringify(data)
      comment = JSON.parse(res)
      @append_new_comment(comment)

  append_new_comment: (comment) ->
    template = Handlebars.compile( @single_comment_template() )
    @last_comment().after(template(comment))
    pane = @storyViewer().find('.comments').jScrollPane({ animateScroll: true })
    pane.data('jsp').scrollTo(0, 6000)

  story_url: ->
    "/api/stories/#{@story_id}"

  comments_url: (story_id) ->
    "/api/stories/" + story_id + "/comments"

  storyViewer: ->
    $('.storyViewer')

  storyContent: ->
    @storyViewer().find('.storyContent')

  storyComments: ->
    @storyViewer().find('.storyComments')

  storyWindow: ->
    @storyViewer().find('.storyWindow')

  textarea: ->
    @storyViewer().find('.leaveComment textarea')

  loader: ->
    @storyViewer().find('.loader')

  comments_dom: ->
    @storyViewer().find('.comments')

  last_comment: ->
    @storyViewer().find('.comments .comment').last()

  single_comment_template: ->
    $('#single_comment_template').html()

  bind_events: ->
    @bind_close_click()
    @bind_comment_post()
    @bindLikeClick()
    @bindDownvoteClick()

  bindLikeClick: ->
    @storyViewer().find('#storyControls #like').bind 'click', {controller: this}, (event) ->
      controller = event.data.controller
      event.preventDefault
      story = new Brwnppl.StoryController(controller.story.id)
      story.like( =>
        textNode = $(@).next()
        oldCount = parseInt( textNode.text() )
        oldCount += 1
        textNode.text(oldCount)
        )

  bindDownvoteClick: ->
    @storyViewer().find('#storyControls #downvote').bind 'click', {controller: this}, (event) ->
      controller = event.data.controller
      event.preventDefault
      story = new Brwnppl.StoryController(controller.story.id)
      story.dislike( =>
        textNode = $(@).prev()
        oldCount = parseInt( textNode.text() )
        oldCount -= 1 if oldCount > 0
        textNode.text(oldCount)
        )

  bind_close_click: ->
    @storyViewer().find('.storyClose').bind 'click', {controller: this}, (event) ->
      controller = event.data.controller
      event.preventDefault()
      controller.storyViewer().remove()

  bind_comment_post: ->
    @storyViewer().find('.leaveComment .roundedButton').bind 'click', { controller: this}, (event) ->
      controller = event.data.controller
      event.preventDefault()
      comment_text = controller.textarea().val()
      story_id = @story_id
      controller.postComment(comment_text, story_id) if comment_text != ""
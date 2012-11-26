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
      data     :   { url : story.url }
      complete :   (data, status) =>
        response = JSON.parse(data.responseText)
        story.html = response.html
        if story.image or story.html
          data = { story: story, comments: comments, user: @current_user }
          @render(data)
          @bind_events()
          @bind_pusher()
        else
          window.location.href = '/v/' + @story.slug

  postComment: (comment_text) ->
    @loader().show()
    $.ajax
      url       :   @comments_url(@story_id)
      type      :   'POST'
      dataType  :   'json'
      data      :   { content: comment_text }
      complete  :   (data, status) =>
        @loader().hide()
        @textarea().val('')
        comment = JSON.parse(data.responseText)
        @append_new_comment(comment)

  render: (data)->
    source = $('#story_viewer_template').html()
    template = Handlebars.compile(source)
    $('#wrapper').prepend(template(data))

  bind_pusher: ->
    pusher = new Pusher('485e4d3a43a88d8be69c')
    channel = pusher.subscribe(@story_id.toString())
    channel.bind 'new-comment', (data) =>
      res = JSON.parse(data.comment)
      comment = res[0]
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

  textarea: ->
    @storyViewer().find('.leaveComment textarea')

  loader: ->
    @storyViewer().find('.loader')

  comments: ->
    @storyViewer().find('.comments')

  last_comment: ->
    @storyViewer().find('.comments .comment').last()

  single_comment_template: ->
    $('#single_comment_template').html()

  bind_events: ->
    @bind_close_click()
    @bind_comment_post()

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
      controller.postComment(comment_text, story_id)
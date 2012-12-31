class IframeController

  constructor: (story_id) ->
    @story_id = story_id

  bind_events: ->
    @commentsDropdown()
    @thumbUpClick()
    @postCommentClick()

  commentsDropdown: ->
    @commentsIcon().click (event) ->
      $('.commentsDropdown').slideToggle(400)

  postComment: (comment_text) ->
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

  thumbUpClick: ->
    @thumbUpIcon().click (event) ->
      story = new Brwnppl.StoryController(@story_id)
      story.like($(@))

  postCommentClick: ->
    @postCommentButton().click (event) =>
      @postComment @commentTextbox().val()

  postCommentButton: ->
    $('.leaveComment .roundedButton')

  commentsIcon: ->
    $('#storyControls .comments')

  commentTextbox: ->
    $('.leaveComment textarea')

  thumbUpIcon: ->
    $('.thumb_')

  comments_url: (story_id) ->
    "/api/stories/" + story_id + "/comments"



iframe = new IframeController( $('iframe').data('story-id') )
iframe.bind_events()
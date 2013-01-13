class IframeController

  constructor: (story_id) ->
    @story_id = story_id

  bind_events: ->
    @commentsDropdown()
    @thumbUpClick(@story_id)
    @thumbDownClick(@story_id)
    @postCommentClick()

  commentsDropdown: ->
    @commentsIcon().click (event) =>
      $('.commentsDropdown').slideToggle(400, => 
        pane = @allComments().jScrollPane({ animateScroll: true })
        pane.data('jsp').scrollTo(0, 6000)
      )


  postComment: (comment_text) ->
    $.ajax
      url       :   @comments_url(@story_id)
      type      :   'POST'
      dataType  :   'json'
      data      :   { content: comment_text }
      complete  :   (data, status) =>
        @commentTextbox().val('')
        comment = JSON.parse(data.responseText)
        @append_new_comment(comment)

  append_new_comment: (comment) ->
    template = Handlebars.compile( $('#single_comment_template').html() )
    @lastComment().after(template(comment))
    pane = @allComments().jScrollPane({ animateScroll: true })
    pane.data('jsp').scrollTo(0, 6000)

  thumbUpClick: (story_id)->
    @thumbUpIcon().click (event) ->
      story = new Brwnppl.StoryController(story_id)
      story.like( ->
        notification = new Brwnppl.Notification('Successfully Liked!', ['Thanks for liking this story'])
        notification.display()
        )
  
  thumbDownClick: (story_id)->
    @thumbDownIcon().click (event) ->
      story = new Brwnppl.StoryController(story_id)
      story.dislike( ->
        notification = new Brwnppl.Notification('Successfully Down-voted!', ['Thanks for down-voting this story'])
        notification.display()
        )

  postCommentClick: ->
    @postCommentButton().click (event) =>
      console.log @commentTextbox().val()
      @postComment @commentTextbox().val()

  postCommentButton: ->
    $('.leaveComment .roundedButton')

  allComments: ->
    $('.commentsDropdown .comments')

  commentsIcon: ->
    $('#storyControls .comments')

  commentTextbox: ->
    $('.leaveComment textarea')

  thumbUpIcon: ->
    $('.thumb_up')

  thumbDownIcon: ->
    $('.thumb_down')

  lastComment: ->
    $('.commentsDropdown .comments .comment').last()

  comments_url: (story_id) ->
    "/api/stories/" + story_id + "/comments"



iframe = new IframeController( $('iframe').data('story-id') )
iframe.bind_events()
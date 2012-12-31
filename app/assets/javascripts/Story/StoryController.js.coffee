class Brwnppl.StoryController

  constructor: (story_id) ->
    @story_id = story_id

  like: (element) ->
    $.ajax
      url:    '/api/likes'
      data:   { story_id: @story_id }
      type:   "POST"
      success: (data) =>
        likeCount = element.next()[0]
        oldCount = parseInt likeCount.textContent
        likeCount.textContent = oldCount + 1
      statusCode: 
        422: (data) ->
          alert 'You already like this story.'

  dislike: (element) ->
    $.ajax
      url:    '/api/dislikes'
      data:   { story_id: @story_id }
      type:   "POST"
      success: (data) =>
        likeCount = element.prev()[0]
        oldCount = parseInt likeCount.textContent
        likeCount.textContent = oldCount - 1
      statusCode: 
        422: (data) ->
          alert 'You already down-voted this story.'
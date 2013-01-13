class Brwnppl.StoryController

  constructor: (story_id) ->
    @story_id = story_id

  like: (element) ->
    $.ajax
      url:    '/api/likes'
      data:   { story_id: @story_id }
      type:   "POST"
      success: (data) =>
        if _.isFunction(element)
          element()
        else
          likeCount = element.next()[0]
          oldCount = parseInt likeCount.textContent
          likeCount.textContent = oldCount + 1 if oldCount >= 0
          $(element).attr('title', 'Thanks for upvoting this story!')
      statusCode: 
        422: (data) ->
          console.warn 'Cannot like: Already Liked.'

  reshare: (element) ->
    $.ajax
      url:    '/api/reshare'
      data:   { story_id: @story_id }
      type:   "POST"
      success: (data) =>
        if _.isFunction(element)
          element()
      statusCode:
        422: (data) ->
          console.warn 'Cannot reshare.'

  dislike: (element) ->
    $.ajax
      url:    '/api/dislikes'
      data:   { story_id: @story_id }
      type:   "POST"
      success: (data) =>
        if _.isFunction(element)
          element()
        else
          likeCount = element.prev()[0]
          oldCount = parseInt likeCount.textContent
          likeCount.textContent = oldCount - 1 if oldCount > 0
      statusCode: 
        422: (data) ->
          console.warn 'Cannot Down-vote: Already down voted.'
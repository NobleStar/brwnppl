class Brwnppl.Models.Story extends Backbone.Model

  likeStory: (clicked_element) ->
    $.ajax({
      type    : 'POST',
      url     : 'api/likes',
      data    : { story_id: @.get('slug') },
      context : this,
      complete: (data) ->
        @.updateLikeCount(clicked_element) if data.status is 200
        alert 'You already like this comment!' if data.status is 422
    })

  updateLikeCount: (clicked_element) ->
    like_count = parseInt( clicked_element.text() )
    clicked_element.html('')
    clicked_element.append( "<span class='icon details thumb'></span> #{like_count+1}" )
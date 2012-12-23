jQuery ->

  $('.filter').click (event) ->
    storyType = $(@).data 'content-type'
    $('.filter').removeClass 'disabled'
    $(@).addClass 'disabled' 

    if storyType == 'all'
      $('.post').slideDown(500)
    else
      
      $('.post').slideDown(500)
      storyType = $(@).data 'content-type'

      _.each $('.post'), (post) ->
        postType = $(post).data 'content-type'
        if storyType != postType
          $(post).slideUp(500)
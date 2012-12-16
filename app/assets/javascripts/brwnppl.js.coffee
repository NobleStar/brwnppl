$(document).ready ->

  $('body').ajaxError (event, request, settings) ->
    if request.status isnt 422
      console.warn 'Ajax Error: (Event): '
      console.dir event
      console.warn 'Ajax Error: (Request): '
      console.dir request

      notification = new Brwnppl.Notification('Something went wrong!', ['Our servers are not in the best state of their health and we experienced some unexpected problem.'])
      notification.display()

  # if navigator.geolocation
  #   navigator.geolocation.getCurrentPosition( myFunc(), null )

  $('a#communities').toggle(
    ->
      $('.background').animate { height: 310}, 500
      
      $('.backgroundContainer').animate { height: 310 }, 500, ->
          $(@).find('.communities').removeClass('hidden')

    ->
      $('.background').animate { height: 69}, 500
      
      $('.backgroundContainer').animate { height: 71 }, 500, ->
          $(@).find('.communities').addClass('hidden')
    )

  $('.post').mouseenter (event) -> 
    $(this).addClass('postShadow')
  
  $('.post').mouseleave (event) -> 
    $(this).removeClass('postShadow')
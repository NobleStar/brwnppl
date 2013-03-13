$(document).ready ->

  $('body').ajaxError (event, request, settings) ->
    if request.status isnt 422
      console.warn 'Ajax Error: (Event): '
      console.dir event
      console.warn 'Ajax Error: (Request): '
      console.dir request

      notification = new Brwnppl.Notification('Something went wrong!', ['Our servers are not in the best state of their health and we experienced some unexpected problem.'])
      notification.display()

  $('a#communities').click (event) ->
    dom = $('.backgroundContainer')
    communitiesDom = dom.find('.communities')
    if communitiesDom.is(":hidden")
      $('.background').animate { height: 310}, 500
      $('.backgroundContainer').animate { height: 310 }, 500, ->
        $(@).find('.communities').removeClass('hidden')
    else
      $('.background').animate { height: 69}, 500
      $('.backgroundContainer').animate { height: 71 }, 500, ->
        $(@).find('.communities').addClass('hidden')

  $('.thumb_up').tooltipster()
  $('.thumb_down').tooltipster()
  $('.repost_').tooltipster()
  $('.tooltip').tooltipster({
      fixedWidth: 400
    })

  # $('a#search').toggle(
  #   ->
  #     $('.background').animate { height: 160}, 250
      
  #     $('.backgroundContainer').animate { height: 160 }, 500, ->
  #         $(@).find('.search').removeClass('hidden')

  #   ->
  #     $('.background').animate { height: 69}, 500
      
  #     $('.backgroundContainer').animate { height: 71 }, 500, ->
  #         $(@).find('.search').addClass('hidden')
  #   )

  $('.post').mouseenter (event) -> 
    $(this).addClass('postShadow')
  
  $('.post').mouseleave (event) -> 
    $(this).removeClass('postShadow')
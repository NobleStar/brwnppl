class Brwnppl.Views.Sharer extends Backbone.View
  
  template: JST['sharer/index']

  initialize: ->
    @model.on('change', @render, this)

  events:
    'keyup input.linkBar'    :  'fetch_link_details'
    'click #shareThis'  :  'share_link'

  render: ->
    $(@el).html(@template(user: @model))
    this

  fetch_link_details: ->
    $('.loader').show()
    $('textarea.linkBar').show()
    url = new Brwnppl.Models.Sharer()
    url.path = $('input.linkBar').val()
    if(url.path)
      url.fetch
        error: ->
          $('textarea.linkBar').val('Error fetching the URL or Invalid URL')
        success: ->
          $('.loader').hide()
          if(url.get('title'))
            $('textarea.linkBar').val(url.get('title'))
          else
            $('textarea.linkBar').val('Error fetching the URL')
    
  share_link: (event) ->
    event.preventDefault()
    link = $('input.linkBar').val()
    title = $('textarea.linkBar').val()
    if (link && title)
      story = new Brwnppl.Models.Story({ title: title, url: link })
      story.save()
      console.log(story)
      
    else 
      alert('Unable to share your story without a proper Link or Description')
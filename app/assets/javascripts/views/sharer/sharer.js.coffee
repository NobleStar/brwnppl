class Brwnppl.Views.Sharer extends Backbone.View
  
  template: JST['sharer/index']

  initialize: ->
    @model.on('change', @render, this)

  events:
    'keyup .linkBar'    :  'fetch_link_details'
    'click #shareThis'  :  'share_link'

  render: ->
    $(@el).html(@template(user: @model))
    this

  fetch_link_details: ->
    $('.loader').show()
    $('textarea.linkBar').show()
    url = new Brwnppl.Models.Sharer()
    url.path = $('input.linkBar').val()
    url.fetch
      error: ->
        $('textarea.linkBar').val('Error fetching the URL')
      success: ->
        $('.loader').hide()
        if(url.get('title'))
          $('textarea.linkBar').val(url.get('title'))
        else
          $('textarea.linkBar').val('Error fetching the URL')
    
  share_link: ->
    $('input.linkBar').val()

    
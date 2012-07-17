class Brwnppl.Views.Sharer extends Backbone.View
  
  template: JST['sharer/index']

  events:
    'keyup .linkBar'    :  'fetch_link_details'
    'click #shareThis'  :  'share_link'

  render: ->
    $(@el).html(@template())
    this

  fetch_link_details: ->
    $('.loader').show()
    $('textarea.linkBar').show()

  share_link: ->
    $('input.linkBar').val()

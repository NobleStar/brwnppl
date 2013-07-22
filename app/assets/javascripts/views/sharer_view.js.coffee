class Brwnppl.Views.SharerView extends Backbone.View

  el: '#add_story'

  events: 
    'input input'         : 'checkStory'
    'click #shareButton'  : 'postStory'

  initialize: ->
    $(@el).find('textarea').textareaAutosize();
    $(@el).on('hidden', {context: this}, @resetModal)
    _.bindAll(this, 'postStory', 'postStorySuccess')

  checkStory: (event) ->
    url = $(event.target).val()
    if @isUrl(url)
      @linkField().attr('disabled', true)
      @removeDiscussionOption()
      @fetchStoryDetails(url)
    else
      @setDiscussionOption()
      @communitySelect().show()

  fetchStoryDetails: (url) ->
    @loader().show()
    @previewArea().empty()
    $.ajax
      context  :  this
      url      :  '/api/url_fetcher'
      type     :  'GET'
      dataType :  'json'
      data     :  { url: url }
      complete :  @renderStoryPreview
      error    :  @failedFetching

  renderStoryPreview: (data, status) ->
    @loader().hide()
    json = $.parseJSON(data.responseText)
    @setFieldValues(json)
    @showAllFields()

  setFieldValues: (json) ->
    @preparePreview(json)
    @setTitle(json.title)

  setTitle: (title) ->
    @titleField().val(title)

  preparePreview: (json) ->
    if json.html
      @previewArea().append(json.html)
    else if json.image
      @previewArea().append(@previewImage(json.image))
    
    if json.image
      @hiddenImageField().val(json.image)


  previewImage: (image_link)->
    return "<img src=" +image_link+ " style='max-width: 530px'>"

  showAllFields: ->
    @titleField().show()
    @communitySelect().show()
    @contentTypeSelect().show()

  resetAllFields: ->
    @titleField().val("")
    @communitySelect().val("")
    @contentTypeSelect().val("")
    @hiddenImageField().val("")
    @previewArea().empty()

    # @titleField().hide()
    # @communitySelect().hide()
    # @contentTypeSelect().hide()

  failedFetching: (data, status)->
    alertify.alert('Failed to fetch this story.')

  removeDiscussionOption: ->
    @contentTypeSelect().children('option[value=discussion]').remove()

  setDiscussionOption: ->
    @contentTypeSelect().val('discussion')

  isUrl: (link) ->
    if ( /^([a-z]([a-z]|\d|\+|-|\.)*):(\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?((\[(|(v[\da-f]{1,}\.(([a-z]|\d|-|\.|_|~)|[!\$&'\(\)\*\+,;=]|:)+))\])|((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=])*)(:\d*)?)(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*|(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)|((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)|((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)){0})(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(link) )
      return true
    else
      return false

  postStory: (event)->
    event.preventDefault()
    attrs = $(@el).find('.tab-pane.active').find('form').serializeObject()
    attrs.type = 'Discussion' if attrs.content_type == 'discussion'
    story = new Brwnppl.Models.Story(attrs)
    story.save({}, {
      success: @postStorySuccess
      error: @postStoryFail
      })

  postStorySuccess: (model, response) ->
    $(@el).modal('hide')
    alertify.alert(response.header + "<p>" + response.messages.join("</p><p>") + "</p>") 

  postStoryFail: (model, response) ->
    response = JSON.parse(response.responseText)
    alertify.alert(response.header + "<p>" + response.messages.join("</p><p>") + "</p>") 

  titleField: ->
    $(@el).find('textarea#title')

  linkField: ->
    $(@el).find('input#link')

  communitySelect: ->
    $(@el).find('select#community')

  contentTypeSelect: ->
    $(@el).find('select#content_type')

  loader: ->
    $(@el).find('.loader')

  previewArea: ->
    $(@el).find('#preview')

  shareButton: ->
    $(@el).find('#shareButton')

  hiddenImageField: ->
    $(@el).find('#image')

  resetModal: (event)->
    event.data.context.resetAllFields()
    event.data.context.linkField().val("")
    event.data.context.linkField().attr('disabled', false)
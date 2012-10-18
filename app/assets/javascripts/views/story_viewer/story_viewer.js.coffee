class Brwnppl.Views.StoryViewer extends Backbone.View

  template: JST['story_viewer/index']

  initialize: ->
    url = new Brwnppl.Models.Sharer()
    if url.set({ path: @model.get('url') })
      url.path = url.get('path')
      url.fetch
        error: ->
          console.log('some error')
        success: (model, response) =>
          if response.html or response.image
            @model.set({ html: response.html })
            $('#storyViewer').html(@.render().el);
          else
            window.location = window.location.href + 'v/' + @model.get('slug')

  render: ->
    $('body').css('overflow', 'hidden')
    $(@el).html(@template(story: @model))
    this

  events:
    'click .storyViewerClose'     :   'closeStoryViewerDialog'
    'click .fader'                :   'closeStoryViewerDialog'
    'mouseover .commentsGutter'   :   'showScrollbar'
    'mouseout .commentsGutter'    :   'hideScrollbar'
    'keypress textarea#newComment':   'addComment'

  showScrollbar: ->
    $('.commentsGutter').css('overflow', 'auto')

  hideScrollbar: ->
    $('.commentsGutter').css('overflow', 'hidden')

  closeStoryViewerDialog: ->
    $('body').css('overflow', 'scroll')
    $(@el).remove()

  addComment: (event) ->
    if event.charCode == 13
      comment = new Brwnppl.Models.Comment({ 
        story_id: this.model.get('id'), 
        content: $('textarea#newComment').val() 
      })
      comment.story_id = this.model.get('id')
      if comment.save()
        @comment = comment
        @.triggerCommentAnimation()

  triggerCommentAnimation: ->
    data =
      story:
        user:
          avatar: window.sessionUser.get('avatar')
      comment:
        text: @comment.get("content")
    $('#comment textarea').val('')
    template = Handlebars.compile $('#comment_template').html()
    html = template(data)
    $('#comments').append(html)
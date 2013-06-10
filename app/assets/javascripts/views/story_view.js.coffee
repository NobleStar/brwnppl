class Brwnppl.Views.StoryView extends Backbone.View

  tag: 'div'

  render: ->
    source = $('#single-story').html()
    template = Handlebars.compile(source)
    $(@el).append( template({ story: @attributes }) )


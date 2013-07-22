class Brwnppl.Views.UserProfile extends Backbone.View

  el: '#app-root'

  initialize: (options)->
    @model = new Brwnppl.Models.User({ username: options.username })
    @model.on('change', @render, this)
    @model.fetch()

  render: ->
    source = $('#user-profile').html()
    template = Handlebars.compile(source)
    $('.pagination').empty()
    $(@el).empty()
    $(@el).append( template({user: @model.attributes }) )

    userStories = new Brwnppl.Collections.Stories([], {})
    userStories.reset(@model.get('stories'))

    html = _.map userStories.models, (story) =>
      storyView = new Brwnppl.Views.StoryView(story)
      storyView.render().html()

    @$el.find('#user_stories').html html

    Magnific.initialize()

class Brwnppl.Views.UserProfile extends Backbone.View

  el: '#app-root'

  events:
    'click #follow': 'follow'
    'click #unfollow': 'unfollow'

  initialize: (options)->
    @model = new Brwnppl.Models.User({ username: options.username })
    @model.on('change', @render, this)
    @model.fetch()

  follow: (event) ->
    @model.follow(@)

  unfollow: (event) ->
    @model.unfollow(@)

  showUnfollowButton: ->
    $(this.el).find('a#follow')
      .attr('id', 'unfollow')
      .html("<span class='fui-cross'></span>Unfollow")

  showFollowButton: ->
    $(this.el).find('a#unfollow')
      .attr('id', 'follow')
      .html("<span class='fui-plus'></span>Follow")


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

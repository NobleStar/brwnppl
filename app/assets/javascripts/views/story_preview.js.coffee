class Brwnppl.Views.StoryPreview extends Backbone.View

  el: '#storyPreview'

  events: 
    'click #likeButton': 'likeStory'

  likeStory: ->
    console.log 'shall like story'

  initialize: (options) ->
    @url = options.url
    @title = options.title

  render: ->
    adapter = @scanForAdapter(@url)
    html = @[adapter](@url)
    $(@el).append(html)

  scanForAdapter: (url) ->
    return 'youtube_short'  if _.str.include(url, 'youtu.be/')
    return 'youtube_full'   if _.str.include(url, 'youtube.com/')
    return 'soundcloud'     if _.str.include(url, 'soundcloud.com/')
    return 'image'          if _.str.endsWith(url, '.gif')
    return 'image'          if _.str.endsWith(url, '.png')
    return 'image'          if _.str.endsWith(url, '.jpg')
    return 'image'          if _.str.endsWith(url, '.bmp')
    return 'link'


  youtube_short: (url) ->
    video_id = url.split('/')[3]
    "<div id='video'><iframe src=http://youtube.com/embed/" +video_id+ " frameborder='0' allowfullscreen webkitallowfullscreen mozallowfullscreen></iframe></div>"

  youtube_full: (url) ->
    video_id = url.split('v=')[1]
    "<div id='video'><iframe src=http://youtube.com/embed/" +video_id+ " frameborder='0' allowfullscreen webkitallowfullscreen mozallowfullscreen></iframe></div>"

  soundcloud: (url) ->
    "<div id='soundcloud'><iframe src=https://w.soundcloud.com/player/?url=#{url}&amp;color=ff6600&amp;auto_play=true&amp;show_artwork=true></iframe></div>"

  image: (url) ->
    "<div id='image'><img src=#{url}></div>"

  link: (url) ->
    "<a href='#{url}' target='_blank' data-bypass=true><div class='alert alert-success' style='min-height: 150px;'><p>#{@title}</p></div></a>"
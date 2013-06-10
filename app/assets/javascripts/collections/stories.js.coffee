class Brwnppl.Collections.Stories extends Backbone.Collection

  initialize: (models, options)->
    @sort = options.sort
    @time = options.time
    @page = options.page
    @slug = options.slug
    @on('stories:finishLoad', @setPagination, this)
    @on('stories:finishLoad', @addPaginationView, this)
    @on('stories:finishLoad', @hideLoader, this)

    @on('stories:startLoad', @showLoader, this)

  url: ->
    "/api/stories/" + @sort + "?time=" + @time + '&page=' + @page + '&slug=' + @slug

  model: Brwnppl.Models.Story

  setPagination: ->
    @next_page = @models[0].get('next_page')
    @previous_page = @models[0].get('previous_page')

  renderView: ->
    @trigger('stories:startLoad')
    @fetch({
      success: (collection, response, options) ->
        collection.trigger('stories:finishLoad')
        storiesView = new Brwnppl.Views.StoriesView({collection: collection})
        storiesView.renderAll()
      error: ->
        alertify.alert('<span class="fui-alert"></span> Failed to load stories')
      reset: true
    })

  previous: ->
    @page = @previous_page
    @renderView()
  
  next: ->
    @page = @next_page
    @renderView()
  
  addPaginationView: ->
    @paginationView = new Brwnppl.Views.PaginationView({ collection: this })
    @paginationView.render()

  showLoader: ->
    $('.loader').show()

  hideLoader: ->
    $('.loader').hide()
class Brwnppl.Views.PaginationView extends Backbone.View

  el: '#pagination'
  tagName: 'div'

  render: ->
    source = $('#pagination_template').html()
    template = Handlebars.compile(source)
    @$el.html( template({ paginate: @collection}) )
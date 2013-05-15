window.Brwnppl =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    window.router = new Brwnppl.Routers.RootRouter();
    Backbone.history.start({ pushState: true });

$(document).ready ->
  Brwnppl.initialize()

  $('.dropdown-toggle').dropdown();

# Fix for pushState on Links:
$(document).on('click', 'a:not([data-bypass])', (evt) -> 
  href = $(this).attr('href');
  protocol = this.protocol + '//';
  if href.slice(protocol.length) != protocol 
    evt.preventDefault();
    window.router.navigate(href, true);
);
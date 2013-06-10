window.Brwnppl =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    window.router = new Brwnppl.Routers.RootRouter();
    Backbone.history.start({ pushState: true });
    sharer = new Brwnppl.Views.SharerView({ el: '#add_story'});

$.fn.serializeAll = ->
  data = $(this).serializeArray()
  $(":disabled[name]", this).each ->
    data.push
      name: @name
      value: $(this).val()
  data
  
$.fn.serializeObject = ->
  o = {}
  a = @serializeAll()
  $.each a, ->
    if o[@name] isnt `undefined`
      o[@name] = [o[@name]]  unless o[@name].push
      o[@name].push @value or ""
    else
      o[@name] = @value or ""
  o

$(document).ready ->  
  Brwnppl.initialize();
  $('.dropdown-toggle').dropdown();

  $(".nav-tabs a").on('click', (e) ->
    e.preventDefault();
    $(this).tab("show");
  )

# Fix for pushState on Links:
$(document).on('click', 'a:not([data-bypass])', (evt) -> 
  href = $(this).attr('href');
  protocol = this.protocol + '//';
  if href.slice(protocol.length) != protocol 
    evt.preventDefault();
    window.router.navigate(href, true);
);


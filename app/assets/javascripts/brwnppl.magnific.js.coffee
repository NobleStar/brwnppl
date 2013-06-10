window.Magnific =
  initialize: ->
    $('.link').magnificPopup({
      preloader: true,
      callbacks: {
        elementParse: (item) ->
          item.src = item.el.data('mfp-source')
        markupParse: (template, values, item) ->
          values.storyLink_href = $(item.el).attr('href')
          values.facebookShareLink_href = item.el.data('facebook-share-link')
          values.twitterShareLink_href = item.el.data('twitter-share-link')
          values.likesCount = item.el.data('mfp-like-count')
          values.commentCount = item.el.data('mfp-comment-count')
      },
      image: {
        markup: '<div class="mfp-figure jasdeep">'+
          '<div class="mfp-close"></div>'+
          '<div class="mfp-img"></div>'+
          '<div class="mfp-bottom-bar">'+
            '<div class="mfp-title"></div>'+
            '<div class="mfp-counter"></div>'+
          '</div>'+
          '<div class="mfp-iconbar iconbar iconbar-vertical">'+
            '<ul>'+
              '<li><a data-bypass=true target="_blank" class="fui-facebook mfp-facebookShareLink"></a></li>'+
              '<li><a data-bypass=true target="_blank" class="fui-twitter mfp-twitterShareLink"></a></li>'+
              '<li><a data-bypass=true class="fui-chat mfp-storyLink"><span class="iconbar-unread mfp-commentCount"></span></a></li>'+
              '<li><a data-bypass=true class="fui-heart mfp-storyLink"><span class="iconbar-unread mfp-likesCount"></span></a></li>'+
            '</ul>'+
          '</div>'+
        '</div>',
        cursor: '',
        titleSrc: 'title',
        verticalFit: true,
        tError: '<a href="%url%">The image</a> could not be loaded.'
      },

      iframe: {
        markup: '<div class="mfp-iframe-scaler">'+
                  '<div class="mfp-close"></div>'+
                  '<iframe class="mfp-iframe" frameborder="0" allowfullscreen></iframe>'+
                  '<div class="mfp-iconbar mfp-iframe-iconbar iconbar iconbar-vertical">'+
                    '<ul>'+
                      '<li><a data-bypass=true target="_blank" class="mfp-facebookShareLink fui-facebook"></a></li>'+
                      '<li><a data-bypass=true target="_blank" class="fui-twitter mfp-twitterShareLink"></a></li>'+
                      '<li><a data-bypass=true class="fui-chat mfp-storyLink"><span class="iconbar-unread mfp-commentCount"></span></a></li>'+
                      '<li><a data-bypass=true class="fui-heart mfp-storyLink"><span class="iconbar-unread mfp-likesCount"></span></a></li>'+
                    '</ul>'+
                  '</div>'+
                '</div>',

        patterns: {
          youtube: {
            index: 'youtube.com/',
            id: 'v=',
            src: '//www.youtube.com/embed/%id%?autoplay=1'
          },
          youtube2: {
            index: 'youtu.be',
            id: '/',
            src: '//www.youtube.com/embed/%id%?autoplay=1'
          },
          vimeo: {
            index: 'vimeo.com/',
            id: '/',
            src: '//player.vimeo.com/video/%id%?autoplay=1'
          },
          soundcloud: {
            index: 'soundcloud.com/',
            id: '',
            src: 'https://w.soundcloud.com/player/?url=%id%&amp;color=ff6600&amp;auto_play=true&amp;show_artwork=true'
          }

        }
      }
    });
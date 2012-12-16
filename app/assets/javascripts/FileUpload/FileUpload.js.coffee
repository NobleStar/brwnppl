$ ->

  $('#image_upload').bind 'click', (event) ->
    event.preventDefault()
    $('#fileupload').click()

  $("#fileupload").fileupload
    dataType: "json"
    add: (e, data) ->
      filename = $('<span id="filename">').text(data.files[0].name)
      $("#image_upload").hide().after(filename)
      button = $("<button/>").text("Upload")
      data.context = $(this).after(button).next().click(->
        $('.loader').show()
        $(this).replaceWith $("<span id='uploading'>").text("Uploading...")
        data.submit()
      )

    done: (e, data) ->
      $('.loader').hide()
      $('span#filename').remove()
      $('span#uploading').remove()

      imageContainer = $('.shareSection').find('#linkBarImage')
      storyImageInput = $('#story_image')
      
      imageContainer.attr('src', data.result.url).show()
      storyImageInput.val(data.result.url)


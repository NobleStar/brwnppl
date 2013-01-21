$ ->

# Story Image Uploads
  $('#image_upload').live 'click', (event) ->
    event.preventDefault()
    $('#fileupload').click()

  $("#fileupload").fileupload
    dataType: "json"
    add: (e, data) ->
      $('.fileType').remove()

      filename = $('<span id="filename">').text(data.files[0].name)
      $("#image_upload").hide().after(filename)
      $('.loader').show()
      $("<span id='uploading'>").text("Uploading...").insertAfter $(this)
      data.submit()

    done: (e, data) ->
      $('.loader').hide()
      $('span#filename').remove()
      $('span#uploading').remove()

      $('#shareForm input.linkBar').hide()
      $('#shareForm input.linkBar').val(data.result.url).trigger('propertyChange')

      imageContainer = $('.shareSection').find('#linkBarImage')
      storyImageInput = $('#story_image')
      
      imageContainer.attr('src', data.result.url).show()
      storyImageInput.val(data.result.url)

    fail: (e, data) ->
      $('.loader').hide()
      $('span#filename').remove()
      $('span#uploading').remove()
      $('<span class=fileType>  We are sorry, but that file type is not supported. Want to try again?</span>').insertAfter $('#image_upload')
      $('#image_upload').show()

# Profile Image Uploads
  $('#profile_upload').click (event) ->
    event.preventDefault()
    $('#profile_image_fileupload').click()

  $("#profile_image_fileupload").fileupload
    dataType: "json"
    type:     "POST"
    add: (e, data) ->
      $('span.hidden').show()
      data.submit()

    done: (e, data) ->
      $('span.hidden').hide()
      $('#CompletePhoto .frame img').attr('src', data.result.user_thumbnail)
      $('form#CompleteAccount #user_avatar').val(data.result.user_thumbnail)

    fail: (e, data) ->
      alert('Failed to upload your image, Please try using a different image, or make sure you are using a valid image format (png or jpgs only).')
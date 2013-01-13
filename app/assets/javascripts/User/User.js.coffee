class Brwnppl.User

  constructor: ->
    $.ajax
      url       :  '/api/users/me'
      dataType  :  'json'
      complete  :  (data, status) =>
        @current_user = JSON.parse(data.responseText)
        
    @current_user
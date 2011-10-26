$(document).ready ->

  #Add a new category from the add/edit post admin page
  window.admin_blog =
    new_category: (category, post_id) ->
      ajax_params = 
        type: "POST"
        url: "/admin/blog/categories.js"
        data:
          "category": category 
          "post": post_id

      $.ajax(ajax_params)
    
    delete_tag: (tag) ->
      ajax_params = 
        type: "DELETE"
        url: "/admin/blog/tags.js"
        data:
          "tag": tag

      $.ajax(ajax_params)
    
    create_tag: (tag) ->
      ajax_params = 
        type: "POST"
        url: "/admin/blog/tags.js"
        data:
          "tag": tag

      $.ajax(ajax_params)
  
  tag_input =
    check_for_seperator: (that,seperator) ->
      str = $(that).val()
      if(str.charAt(str.length - 1) == seperator )
        str_arr = str.split(seperator)
        admin_blog.create_tag(str_arr[0])
        $(that).val(str_arr[1])


  #bindings
  # insert new tag when the comma is used as a seperator
  $(".tag_input")
  .bind 'keyup', (evt) -> 
    tag_input.check_for_seperator(this,',')
  
  .bind 'keydown', (evt) ->
    if(evt.which == 13)
        evt.stopPropagation()
        return false


  # on enter, stop the form from submitting but trigger the add category button event
  $('.new_category')
  .bind 'keydown', (evt) ->
    evt.stopPropagation()
    if(evt.which == 13)
      $(this)
        .siblings(".button")
          .trigger('click')
        .siblings('.new_category')
          .val('')
      return false



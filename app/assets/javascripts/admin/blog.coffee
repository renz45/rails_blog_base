#Add a new category from the add/edit post admin page
#post_id as an argument if the list is to set new updated list to the correct checked

window.admin_blog =
  new_category: (category, post_id) ->
    

    ajax_params = 
      type: "POST"
      url: "/admin/blog/categories.js"
      data:
        "category": category 
        "post": post_id

    $.ajax(ajax_params)




$('.info_table tbody')
  .html("<%= escape_javascript(render('admin/blog/comments/comment_list_table_item', comments: @comments)) %>")
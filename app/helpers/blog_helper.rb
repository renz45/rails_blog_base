module BlogHelper
   
  def show_comments(comment_tree, klass = "comment", reply = false)
    comment_list = ""

    comment_tree.each do |comment_id,c|
      comment = c[:comment]

      if comment.reply_id.nil? || reply
        comment_html = "\n\t" + content_tag(:h3, "By #{comment.author}") + "\n"
        comment_html << "\t" + content_tag(:p, comment.email) + "\n"
        comment_html << "\t" + content_tag(:p, comment.content) + "\n"
        comment_html << "\t" + link_to("Reply", blog_comment_reply_path(post_id: params[:id], reply_id: comment_id) ) + "\n"
        
        comment_list << "\n"+ "\t" + content_tag(:li,comment_html.html_safe, class: klass) + "\n"
        comment_list << "\t" + content_tag(:li, show_comments(c[:replies], "reply", true), class: "reply_container" ) + "\n"
      end
    end
    if comment_list.nil?
      ""
    else
      content_tag(:ul,comment_list.html_safe) + "\n"
    end

  end
end
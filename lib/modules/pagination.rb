module Pagination
  module Comments
    def paginate_comments_for_post(post)
      #paginate comments for the current post which aren't replies with a status of approved(1)
      paginate_me :comments, where: {comments: {post_id: post.id, reply_id: nil, status_id: 1}},
                             base_url: blog_post_path(post.slug),
                             per_page: 5,
                             order: "comments.created_at DESC"
    end
  end

  module Posts
    def paginate_index_posts(path,type = false)
      if type
        status = PostStatus.where(status: type.to_s.downcase).first().id
        paginate_me(:posts, base_url: path, where: {status_id: status}, order: "posts.created_at DESC")
      else
        trashed_status = PostStatus.trashed
        statuses = PostStatus.all.map {|ps| ps.id unless ps.id == trashed_status.id}
        paginate_me(:posts, base_url: path, where: {status_id: statuses.compact}, order: "posts.created_at DESC")
      end
    end

    # NOTE The 4 map functions here could be optimized/refactored
    def paginate_search_posts(tag_group, category_group, path,type = nil)
      # build the url and where/includes statements based on tags and/or categories
      # this seems long because it takes into account both categories or tags seperately
      # or both categories and tags together incase narrowing a search is wanted
      includes = []
      where = {}
      page_url = path

      unless category_group.nil?
        includes << :category_posts
        where[:category_posts] = {category_id: category_group.map {|c| c.id}}
        page_url << "/category/#{category_group.map {|c| c.slug}.join(',')}"
      end

      unless tag_group.nil?
        includes << :post_tags
        where[:post_tags] = {tag_id: tag_group.map {|t| t.id}}
        page_url << "/tag/#{tag_group.map {|t| t.slug}.join(',')}"
      end

      if !type.nil? && type != "all"
        status = PostStatus.where(status: type.to_s.downcase).first().id
        includes << :post_status
        where[:posts] = {status_id: status}
      end

      binding.pry

      paginate_me(:posts, 
                  where: where, 
                  includes: includes, 
                  params_var: :page, 
                  base_url: page_url,  
                  order: "posts.created_at DESC")
    end
  end
end

# SELECT COUNT(*) 
#   FROM "posts" 
# INNER JOIN 
#   "post_statuses" 
#     ON 
#       "post_statuses"."id" = "posts"."status_id" 
# INNER JOIN 
#   "post_tags" 
#     ON 
#       "posts"."id" = "post_tags"."post_id" 
#   WHERE 
#     "post_tags"."tag_id" = 26 
#   AND 
#     "post_statuses"."status" = 'published'

module Pagination
  module Comments
    def paginate_comments_for_post(post)
      #paginate comments for the current post which aren't replies with a status of approved(1)
      paginate_me :comments, where: {comments: {post_id: post.id, reply_id: nil, status_id: 1}},
                             base_url: blog_post_path(post.slug),
                             per_page: 5,
                             order: "created_at DESC"
    end
  end

  module Posts
    def paginate_index_posts(path)
      paginate_me(:posts, params_var: :posts_page, base_url: path)
    end

    # NOTE The 4 map functions here could be optimized/refactored
    def paginate_search_posts(tag_group, category_group)
      # build the url and where/includes statements based on tags and/or categories
      # this seems long because it takes into account both categories or tags seperately
      # or both categories and tags together incase narrowing a search is wanted
      includes = []
      where = {}
      page_url = "/blog"

      unless category_group.nil?
        includes << :category_to_posts
        where[:category_to_posts] = {category_id: category_group.map {|c| c.id}}
        page_url << "/category/#{category_group.map {|c| c.slug}.join(',')}"
      end

      unless tag_group.nil?
        includes << :tag_to_posts
        where[:tag_to_posts] = {tag_id: tag_group.map {|t| t.id}}
        page_url << "/tag/#{tag_group.map {|t| t.slug}.join(',')}"
      end

      paginate_me(:posts, where: where, includes: includes, params_var: :page, base_url: page_url)
    end
  end
end

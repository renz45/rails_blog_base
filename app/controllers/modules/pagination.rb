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

    def paginate_search_posts(tag_id, category_id)
      # build the url and where/includes statements based on tags and/or categories
      # this seems long because it takes into account both categories or tags seperately
      # or both categories and tags together incase narrowing a search is wanted
      includes = []
      where = {}
      page_url = "/blog"

      unless category_id.nil?
        includes << :category_to_posts
        where[:category_to_posts] = {category_id: category_id}
        page_url << "/category/#{category_id}"
      end

      unless tag_id.nil?
        includes << :tag_to_posts
        where[:tag_to_posts] = {tag_id: tag_id}
        page_url << "/tag/#{tag_id}"
      end

      paginate_me(:posts, where: where, includes: includes, params_var: :page, base_url: page_url)
    end
  end
end

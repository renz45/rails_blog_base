atom_feed language: 'en-US' do |feed|
  feed.title @title
  feed.updated @updated

  @feed_items.each do |item|
    next if item.updated_at.blank?

    feed.entry item, url: blog_post_url(item.slug) do |entry|
      entry.url( blog_post_url(item.slug) )
      entry.title item.title
      entry.content markdown(item.content), type: 'html'

      # the strftime is needed to work with Google Reader.
      entry.updated(item.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 

      entry.author do |a|
        a.name User.find(item.user_id).user_name
      end
    end
  end
end

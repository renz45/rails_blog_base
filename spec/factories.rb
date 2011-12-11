#sample usage @category = Factory(:category)

#category
Factory.define :category do |category|
  category.category 'test category'
  category.slug 'test-category'
end

#tag
Factory.define :tag do |tag|
  tag.tag 'test tag'
  tag.slug 'test-tag'
end

#user
Factory.define :user do |user|
  user.email 'user@email.com'
  user.name 'bob metel'
  user.user_name 'bob'
  user.bio 'I am 43.567 years old and a male'
  user.website_url 'www.user.com'
  user.permission_id '5'
end

#post
Factory.define :post do |post|
  post.title 'sample post'
  post.content 'sample post content is sample post content'
  post.user_id '1'
  post.slug 'sample-post'
end

#comment
Factory.define :comment do |comment|
  comment.author 'troll'
  comment.email 'troll@email.com'
  comment.website 'http://www.trollingyou.com'
  comment.content 'I be trolling you this day'
  comment.post_id '1'
  comment.ip_address '1.129.233.21'
end

#permission
Factory.define :permission do |permission|
  permission.permission 'admin'
end

#link
Factory.define :link do |link|
  link.url 'http://www.linkurl.com'
  link.name 'Sample link'
end

#comment_status
Factory.define :comment_status do |comment_status|
  comment_status.status 'spam'
end
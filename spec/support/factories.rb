#sample usage @category = Factory(:category)

#category
Factory.define :category do |category|
  category.sequence(:category) {|n| 'test category#{n}'}
end

#tag
Factory.define :tag do |tag|
  tag.sequence(:tag) {|n| 'test tag#{n}'}
end

#user
Factory.define :user do |user|
  user.sequence(:email) {|n| 'user#{n}@email.com'}
  user.name 'bob metel'
  user.user_name 'bob'
  user.bio 'I am 43.567 years old and a male'
  user.website_url 'www.user.com'
  user.permission_id '5'
  user.password 'secret'
  user.password_confirmation { |u| u.password }
end

#post
Factory.define :post do |post|
  post.sequence(:title) {|n| 'sample post#{n}'}
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
  comment.post {@sample_post ||= Factory(:post)}
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

#post_status
Factory.define :post_status do |post_status|
  post_status.status 'published'
end
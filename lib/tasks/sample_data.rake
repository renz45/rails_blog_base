require 'faker'

namespace :db do
  desc "Fill Database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke

    # create permissions
    Permission.create(permission: "anon")
    Permission.create(permission: "subscriber")
    Permission.create(permission: "author")
    Permission.create(permission: "editor")
    Permission.create(permission: "admin")

    # create comment status
    CommentStatus.create(status: "approved")
    CommentStatus.create(status: "unapproved")
    CommentStatus.create(status: "trash")
    CommentStatus.create(status: "spam")

    # create users
    User.create!(user_name: "admin",
                 name: "adminy",
                 email: "admin@email.com",
                 password: "admin124",
                 password_confirmation: "admin124",
                 permission_id: 5)

    # create 10 users
    10.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@example.org"
      password = "password"
      User.create!(user_name: name,
                  name: "name#{n}",
                  email: email,
                  password: password,
                  password_confirmation: password)
    end

    # create categories
    12.times do |n|
      Category.create!(category: "Category#{n+1}")
    end

    # create tags
    20.times do |n|
      Tag.create!(tag: "Tag#{n+1}")
    end

    # create posts
    50.times do |n|
      p = Post.new(title: Faker::Lorem.words(4).join(" "),
                   content: Faker::Lorem.paragraphs(5).join(" "),
                   user_id: 1+rand(10))
      
      # give post random categories
      num = 1+rand(12)
      num.times do |nm|
        p.categories << Category.find(nm+1)
      end

      # give post random tags
      num = 1+rand(20)
      num.times do |nm|
        p.tags << Tag.find(nm+1)
      end
      
      p.save
    end

    # create comments
    300.times do |n|
        c = Comment.create!(author: Faker::Name.name,
                        email: "commenter#{n}@commentemail.com",
                        website: "www.comment_this#{n}.com",
                        content: Faker::Lorem.paragraphs(1+rand(2)),
                        permission_id: 1 + rand(5),
                        status_id: 1 + rand(4),
                        post_id: 1 + rand(50) )
      
      end
  end

end
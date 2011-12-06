source 'http://rubygems.org'

gem 'rails', '3.1.0'

gem 'heroku'
gem 'json'
gem 'jquery-rails'
gem 'gravatar_image_tag'

gem "redcarpet"
# gem 'paginate_me'
gem 'paginate_me', git: 'git@github.com:renz45/paginate_me.git'
# gem 'paginate_me', :path => 'vendor/plugins/paginate_me/'
gem 'devise'

# there is a bug with 1.3.4, so I'm using the older version for now
gem 'rack', '1.3.3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.3"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
  gem 'compass', '~> 0.12.alpha'
  gem 'haml'
  
end

group :development do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'annotate', git: 'git://github.com/ctran/annotate_models.git'
  gem 'pry'
  gem 'faker'
  
  # mailcatcher
  # Go to http://localhost:1080/
  # Send mail through smtp://localhost:1025
  gem 'mailcatcher'
end

group :test do
  gem 'rspec'
  gem 'webrat'
  gem 'factory_girl'
end

group :production do
  gem 'pg'
end



# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'


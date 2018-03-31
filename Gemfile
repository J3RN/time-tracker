source "https://rubygems.org"

ruby "2.5.0"

gem "rails", "< 5.1"
gem "pg", "~> 0.19.0"
gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"

gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"

# Devise for user authentication
gem "devise"

# Bootstrap stuff
gem "bootstrap-sass"
gem "autoprefixer-rails"

# Datetime picker
gem "momentjs-rails", ">= 2.9.0"
gem "bootstrap3-datetimepicker-rails", "~> 4.17"

# JavaScript runtime
gem "therubyracer"

# Use Dotenv for env vars
gem "dotenv-rails"

# Sentry for error catching
gem "sentry-raven"

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console"
  gem "listen", "~> 3.0.5"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  # Capistrano for deployment
  gem "capistrano", "~> 3.6"
  gem "capistrano-rails", "~> 1.2"
  gem "capistrano-rvm"
  gem "capistrano-passenger"

  # Guard for automation goodies
  gem "guard"
  gem "guard-process"
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug"

  # Awesome print prints Ruby objects awesomely
  gem "awesome_print"

  # Pry-rails for better console
  gem "pry-rails"

  # Rubocop to yell at me about how bad my code is
  gem "rubocop", "~> 0.54.0", require: false
end

group :test do
  # SimpleCov for test coverage
  gem "simplecov", require: false
end

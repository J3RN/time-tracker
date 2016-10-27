source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '~> 5.0.0'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# Devise for user authentication
gem 'devise'

# Bootstrap stuff
gem 'bootstrap-sass'
gem 'autoprefixer-rails'

# Datetime picker
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17'

# Use passenger for server
gem 'passenger'

# Use Dotenv for env vars
gem 'dotenv-rails'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Awesome print
  gem 'awesome_print'

  # Guard for automation goodies
  gem 'guard'
  gem 'guard-process'

  # Capistrano for deployment
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rvm'
  gem 'capistrano-passenger'

  # Pry-rails for better console
  gem 'pry-rails'

  # JavaScript runtime for those Linux users out there
  gem 'therubyracer'
end

group :test do
  # assigns and assert_template in controller tests
  gem 'rails-controller-testing'

  # SimpleCov for test coverage
  gem 'simplecov', require: false
end

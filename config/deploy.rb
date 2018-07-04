# config valid only for current version of Capistrano
lock "3.10.1"

set :application, "timesheet"
set :repo_url, "https://github.com/J3RN/timesheet.git"

# Set RVM as system
set :rvm_type, :system
set :rvm_ruby_version, "2.5.1"

# Use Dotenv for all secrets
set :linked_files, fetch(:linked_files, []).push(".env")

# Share these directories between deploys
set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system")

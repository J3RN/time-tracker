ENV["RAILS_ENV"] ||= "test"

require "simplecov"
SimpleCov.start

require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end

class ActionController::TestCase
  include Devise::Test::ControllerHelpers
end

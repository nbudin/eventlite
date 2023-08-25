ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "minitest/reporters"
if ENV["CI"].present?
  Minitest::Reporters.use!(
    [
      Minitest::Reporters::DefaultReporter.new,
      Minitest::Reporters::JUnitReporter.new
    ],
    ENV,
    Minitest.backtrace_filter
  )
else
  Minitest::Reporters.use!(Minitest::Reporters::ProgressReporter.new, ENV, Minitest.backtrace_filter)
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

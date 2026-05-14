ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def should(user, action_name)
      "#{user} should be able to call #{action_name}"
    end

    def should_not(user, action_name)
      "#{user} should not be able to call #{action_name}"
    end

    def sign_in(user)
      post session_url, params: {
        email_address: user.email_address,
        password: "password"
      }
    end
  end
end

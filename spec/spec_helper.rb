require "bundler/setup"
require "spec_app/config/environment"
require "rspec/rails"
require "rails_action_deprecation"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def send_request(http_method, method, params)
  send http_method, method, params: params
end

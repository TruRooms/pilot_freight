# frozen_string_literal: true

require "simplecov"
SimpleCov.start

require "pilot_freight"

require "byebug"

require "webmock/rspec"

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  # Require everything in spec/support
  Dir[File.expand_path("support/**/*.rb", __dir__)].sort.each { |f| require f }

  # Optional env flag to run tests against the demo server
  if ENV["PILOT_FREIGHT_DEMO_ENDPOINT"]
    config.before(:suite) do
      PilotFreight.configure do |config|
      end
    end
  else
    config.before(:each) do
      stub_request(:any, /demo.mfsclarity.com/).to_rack(FakeClarity)
    end
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

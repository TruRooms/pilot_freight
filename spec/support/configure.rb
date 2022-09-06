# frozen_string_literal: true

def configure_and_deconfigure
  before(:each) do
    PilotFreight.configure do |config|
      config.username = "username"
      config.password = "password"
      config.environment = "test"
    end
  end
  after(:each) do
    PilotFreight.configure do |config|
      config.username = nil
      config.password = nil
      config.environment = "development"
    end
  end
end

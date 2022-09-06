def configure_and_deconfigure
  before(:each) {
    PilotFreight.configure do |config|
      config.username = "username"
      config.password = "password"
      config.environment = "test"
    end
  }
  after(:each) {
    PilotFreight.configure do |config|
      config.username = nil
      config.password = nil
      config.environment = "development"
    end
  }
end
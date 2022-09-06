# PilotFreight

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/TruRooms/pilot_freight/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/TruRooms/pilot_freight/tree/master)

A simple wrapper to make the Pilot API accessbile in a more Ruby friendly way.
Things like dates will be accepted as `Date` and parsed as such.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pilot_freight'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install pilot_freight

## Configuration

3 things are required to be set

- `endpoint` - The endpoint to use for the API, will use the Rails env if available.
- `user_name` - The username to use for the API
- `password` - The password to use for the API

Via initializer
```
PilotFreight.configure do |config|
  config.endpoint = 'http://demo.pilotfreight.com'
  config.user_name = 'username'
  config.password = 'password'
end
```

Via environment variables
```
PILOT_FREIGHT_ENDPOINT='http://demo.pilotfreight.com'
PILOT_FREIGHT_USER_NAME='username'
PILOT_FREIGHT_PASSWORD='password'
```


## Usage

To get started first initialize a client.

```
client = PilotFreight::Client.new(endpoint: '', user_name: '', password: '')
```

This client is aware of Rails and will use the Rails env to set the endpoint for the API
unless it is manually overridden.

All client configuration can also be done via ENV variables.

```
ENV['PILOT_FREIGHT_USER_NAME'] = 'username'
ENV['PILOT_FREIGHT_PASSWORD'] = 'password'
ENV['PILOT_FREIGHT_ENDPOINT'] = 'https://demo.pilotfreight.com'
```

## Testing

To run the tests you will need to set the following ENV variables or set the credentials in `spec/support/credentials.yml`.

```
rspec
```

The helper method `configure_and_deconfigure` will configure the client with the credentials and then deconfigure it after the test is run.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pilot_freight. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/pilot_freight/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PilotFreight project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/pilot_freight/blob/master/CODE_OF_CONDUCT.md).

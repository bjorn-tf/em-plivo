# EventMachine::Plivo

An EventMachine port of [PlivoRuby](https://github.com/plivo/plivo-ruby).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'em-plivo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install em-plivo

## Usage

```ruby
require 'eventmachine'
require 'em-plivo'

EM.run do
  client = EM::Plivo::RestAPI.new(YOUR_AUTH_ID, YOUR_AUTH_TOKEN, :keepalive => true)

  sms = client.send_message(
    :src => '+70000000000',
    :dst => '+71111111111',
    :text => 'I can!',
    :type => 'sms',
  )

  sms.callback do |http_status, http_response|
    p [http_status, http_response]
    EM.stop
  end

  sms.errback do |error|
    p "Error: #{error}"
    EM.stop
  end
end
```

## Documentation
* [Plivo API documentation](https://www.plivo.com/docs/api/).
* [Available methods](https://github.com/plivo/plivo-ruby/blob/master/lib/plivo.rb).

## Contributing

1. Fork it ( https://github.com/bjorn-tf/em-plivo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

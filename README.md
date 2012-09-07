# HotelsPro

HotelsPro API wrapper

## Installation

Add this line to your application's Gemfile:

    gem 'hotels_pro'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hotels_pro

## Configuration

    HotelsPro.configure do |config|
      config.api_key = "your_api_key"       # required
      config.environment = "live"           # "live" or "test"; defaults to "test"
      config.logger = Logger.new(STDOUT)    # optional
      config.only_stubs = false             # optional; defaults to "false"; see 'Stubbing requests' section for details
    end

## Usage

Since this is a really simple wrapper for HotelsPro API it only let's you build API method calls with Ruby and returns responses as Ruby objects. It uses [virtus](https://github.com/solnic/virtus) under the hood to build objects.

    method = HotelsPro::Api::Methods::GetAvailableHotel.new(
      :destination_id => "LD6J",
      :client_nationality => "US",
      :currency => "EUR",
      :check_in => Date.parse("2012-08-14"),
      :check_out => Date.parse("2012-08-21"),
      :rooms => [
        HotelsPro::Api::Elements::PaxArray.new(
          :paxes => [
            HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult"),
            HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult")
          ]
        ),
        HotelsPro::Api::Elements::PaxArray.new(
          :paxes => [
            HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult"),
            HotelsPro::Api::Elements::Pax.new(:pax_type => "Child", :age => 10)
          ]
        )
      ]
    )

    result = method.perform

    result.response_id
    # => 4322779

    result.available_hotels
    # => Array of HotelsPro::Api::Elements::Hotel objects

    result.total_found
    # => 10

    result.search_id
    # => "SZ-91588250"

## Stubbing requests

You can stub requests for testing or to provide fixed responses.

    HotelsPro::Stubs.get_available_hotel.response(json)

The above snippet will stub all requests to getAvailableHotel api method, so they return specified `json` response.

If you want to stub only some requests or to return different response depending on request params, provide a `matcher`.

    matcher = lambda { |request| request.destination_id == "LD6J" }
    HotelsPro::Stubs.get_available_hotel(matcher).response(json)

In testing no requests should hit the remote API. If `only_stubs` configuration option is enabled, exception will be raised anytime an unstubbed request is performed.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

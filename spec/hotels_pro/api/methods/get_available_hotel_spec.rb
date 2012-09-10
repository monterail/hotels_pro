require 'spec_helper'

describe HotelsPro::Api::Methods::GetAvailableHotel do
  include RequestHelper

  it "should build correct api params hash" do
    method = HotelsPro::Api::Methods::GetAvailableHotel.new(
      :destination_id => "XXX",
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
      ],
      :filters => [
        HotelsPro::Api::Elements::Filter.new(:filter_type => "hotelCode", :filter_value => "123"),
        HotelsPro::Api::Elements::Filter.new(:filter_type => "limit", :filter_value => "10")
      ]
    )

    method.to_api_params.should == {
      "destinationId" => "XXX",
      "clientNationality" => "US",
      "currency" => "EUR",
      "checkIn" => "2012-08-14",
      "checkOut" => "2012-08-21",
      "rooms" => [
        [{ "paxType" => "Adult" }, { "paxType" => "Adult" }],
        [{ "paxType" => "Adult" }, { "paxType" => "Child", "age" => "10" }]
      ],
      "filters" => [
        { "filterType" => "hotelCode", "filterValue" => "123" },
        { "filterType" => "limit", "filterValue" => "10" }
      ],
      "onRequest" => "true"
    }
  end

  it "should return result when performed" do
    HotelsPro::Stubs.get_available_hotel.response(fixture("get_available_hotel"))

    method = HotelsPro::Api::Methods::GetAvailableHotel.new(
      :destination_id => "XXX",
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

    result.should be_instance_of HotelsPro::Api::Methods::GetAvailableHotel::Result
    result.response_id.should == 4214740
    result.total_found.should == 2
    result.search_id.should == "SZ-91588250"
  end
end

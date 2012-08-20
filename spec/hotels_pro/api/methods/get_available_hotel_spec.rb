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
      "onRequest" => "true"
    }
  end

  it "should build correct result from hash" do
    hash = {
      "response_id" => 4214740,
      "available_hotels" => [{
        "process_id" => "HM-99621850",
        "hotel_code" => "UKNZDJ",
        "availability_status" => "InstantConfirmation",
        "total_price" => 437,
        "total_tax" => 0,
        "total_sale_price" => 0,
        "currency" => "EUR",
        "board_type" => "English Breakfast",
        "rooms" => [{
          "room_category" => "Triple Standard",
          "paxes" => [
            { "pax_type" => "Adult", "age" => 30 },
            { "pax_type" => "Child", "age" => 10 }
          ],
          "total_room_rate" => 219,
          "rates_per_night" => [
            { "date" => "2012-09-20", "amount" => 0 },
            { "date" => "2012-09-21", "amount" => 73 }
          ]
        }],
      }],
      "total_found" => 10,
      "search_id" => "SZ-91588250"
    }

    result = HotelsPro::Api::Methods::GetAvailableHotel::Result.new(
      :response_id => 4214740,
      :available_hotels => [HotelsPro::Api::Elements::Hotel.new(
        :process_id => "HM-99621850",
        :hotel_code => "UKNZDJ",
        :availability_status => "InstantConfirmation",
        :total_price => 437,
        :total_tax => 0,
        :total_sale_price => 0,
        :currency => "EUR",
        :board_type => "English Breakfast",
        :rooms => [HotelsPro::Api::Elements::RoomResponse.new(
          :room_category => "Triple Standard",
          :paxes => [
            HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :age => 30),
            HotelsPro::Api::Elements::Pax.new(:pax_type => "Child", :age => 10)
          ],
          :total_room_rate => 219,
          :rates_per_night => [
            HotelsPro::Api::Elements::DailyRate.new(:date => Date.parse("2012-09-20"), :amount => 0),
            HotelsPro::Api::Elements::DailyRate.new(:date => Date.parse("2012-09-21"), :amount => 73)
          ]
        )],
        :total_found => 10,
        :search_id => "SZ-91588250"
      )]
    )
  end

  it "should return result when performed" do
    stub_url(/getAvailableHotel/, stub_response("get_available_hotel"))

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
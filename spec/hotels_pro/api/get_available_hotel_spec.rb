require 'spec_helper'

describe HotelsPro::Api::GetAvailableHotel do
  it "should build correct api params hash" do
    method = HotelsPro::Api::GetAvailableHotel.new(
      :destination_id => "XXX",
      :client_nationality => "US",
      :currency => "EUR",
      :check_in => Date.parse("2012-08-14"),
      :check_out => Date.parse("2012-08-21"),
      :rooms => [
        HotelsPro::Api::PaxArray.new(
          :elements => [
            HotelsPro::Api::Pax.new(:pax_type => "Adult"),
            HotelsPro::Api::Pax.new(:pax_type => "Adult")
          ]
        ),
        HotelsPro::Api::PaxArray.new(
          :elements => [
            HotelsPro::Api::Pax.new(:pax_type => "Adult"),
            HotelsPro::Api::Pax.new(:pax_type => "Child", :age => 10)
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
end
require 'spec_helper'

describe HotelsPro::Api::Methods::AmendHotelBooking do
  include RequestHelper

  it "should build correct api params hash" do
    method = HotelsPro::Api::Methods::AmendHotelBooking.new(
      :tracking_id => "XI-HW-82431210",
      :check_in => Date.parse("2012-10-05"),
      :check_out => Date.parse("2012-10-12"),
      :lead_traveller_info => HotelsPro::Api::Elements::LeadTraveller.new(
        :pax_info => HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :title => "Mr", :first_name => "John", :last_name => "Doe"),
        :nationality => "US"
      ),
      :rooms => [
        HotelsPro::Api::Elements::PaxArray.new(
          :paxes => [
            HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :title => "Mr", :first_name => "John", :last_name => "Doe"),
            HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :age => 30, :title => "Mrs", :first_name => "Amanda", :last_name => "Doe")
          ]
        )
      ],
      :preferences => "nonSmoking",
      :note => "I don't like french fries"
    )

    method.to_api_params.should == {
      "trackingId" => "XI-HW-82431210",
      "checkIn" => "2012-10-05",
      "checkOut" => "2012-10-12",
      "leadTravellerInfo" => {
        "paxInfo" => {
          "paxType" => "Adult",
          "title" => "Mr",
          "firstName" => "John",
          "lastName" => "Doe"
        },
        "nationality" => "US"
      },
      "rooms" => [
        [{ "paxType" => "Adult", "title" => "Mr", "firstName" => "John", "lastName" => "Doe" }, { "paxType" => "Adult", "age" => "30", "title" => "Mrs", "firstName" => "Amanda", "lastName" => "Doe" }]
      ],
      "preferences" => "nonSmoking",
      "note" => "I don't like french fries"
    }
  end

  it "should return result when performed" do
    HotelsPro::Stubs.amend_hotel_booking.response(fixture('amend_hotel_booking'))

    method = HotelsPro::Api::Methods::AmendHotelBooking.new(
      :tracking_id => "XI-HW-82431210",
      :check_in => Date.parse("2012-10-05"),
      :check_out => Date.parse("2012-10-12"),
      :lead_traveller_info => HotelsPro::Api::Elements::LeadTraveller.new(
        :pax_info => HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :title => "Mr", :first_name => "John", :last_name => "Doe"),
        :nationality => "US"
      ),
      :rooms => [
        HotelsPro::Api::Elements::PaxArray.new(
          :paxes => [
            HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :title => "Mr", :first_name => "John", :last_name => "Doe"),
            HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :age => 30, :title => "Mrs", :first_name => "Amanda", :last_name => "Doe")
          ]
        )
      ],
      :preferences => "nonSmoking",
      :note => "I don't like french fries"
    )

    result = method.perform

    result.should be_instance_of HotelsPro::Api::Methods::AmendHotelBooking::Result
    result.response_id.should == 5762113
    result.tracking_id.should == "XI-HW-82431210"
    result.amend_status.should == "Pending"
    result.note.should == "Your amendment request has been received. You will be contacted regarding amendment results by email or by message in our online system."
  end
end

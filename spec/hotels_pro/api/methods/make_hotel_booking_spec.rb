require 'spec_helper'

describe HotelsPro::Api::Methods::MakeHotelBooking do
  include RequestHelper

  it "should build correct api params hash" do
    method = HotelsPro::Api::Methods::MakeHotelBooking.new(
      :process_id => "HF-56017745",
      :agency_reference_number => "999",
      :lead_traveller_info => HotelsPro::Api::Elements::LeadTraveller.new(
        :pax_info => HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :title => "Mr", :first_name => "John", :last_name => "Doe"),
        :nationality => "US"
      ),
      :other_traveller_info => [
        HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :age => 30, :title => "Mrs", :first_name => "Amanda", :last_name => "Doe")
      ],
      :preferences => "nonSmoking",
      :note => "I like french fries"
    )

    method.to_api_params.should == {
      "processId" => "HF-56017745",
      "agencyReferenceNumber" => "999",
      "leadTravellerInfo" => {
        "paxInfo" => {
          "paxType" => "Adult",
          "title" => "Mr",
          "firstName" => "John",
          "lastName" => "Doe"
        },
        "nationality" => "US"
      },
      "otherTravellerInfo" => [
        { "paxType" => "Adult", "age" => "30", "title" => "Mrs", "firstName" => "Amanda", "lastName" => "Doe" }
      ],
      "preferences" => "nonSmoking",
      "note" => "I like french fries"
    }
  end

  it "should return result when performed" do
    HotelsPro::Stubs.make_hotel_booking.response(fixture('make_hotel_booking'))

    method = HotelsPro::Api::Methods::MakeHotelBooking.new(
      :process_id => "HF-56017745",
      :agency_reference_number => "999",
      :lead_traveller_info => HotelsPro::Api::Elements::LeadTraveller.new(
        :pax_info => HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :title => "Mr", :first_name => "John", :last_name => "Doe"),
        :nationality => "US"
      ),
      :other_traveller_info => [
        HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :age => 30, :title => "Mrs", :first_name => "Amanda", :last_name => "Doe")
      ],
      :preferences => "nonSmoking",
      :note => "I like french fries"
    )

    result = method.perform

    result.should be_instance_of HotelsPro::Api::Methods::MakeHotelBooking::Result
    result.response_id.should == 5756635
    result.tracking_id.should == "XI-HE-70838364"
    result.hotel_booking_info.should be_instance_of HotelsPro::Api::Elements::BookInfo
    result.hotel_booking_info.hotel_code.should == "US2HZR"
  end
end

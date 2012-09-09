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

  it "should build correct result from hash" do
    hash = {
      "responseId" => 5756635,
      "trackingId" => "XI-HE-70838364",
      "hotelBookingInfo" => {
        "bookingStatus" => 5,
        "confirmationNumber" => "TEST;0000000",
        "supplier" => nil,
        "hotelCode" => "US2HZR",
        "checkIn" => "2012-10-04",
        "checkOut" => "2012-10-11",
        "totalPrice" => "528",
        "currency" => "EUR",
        "totalSalePrice" => 0,
        "boardType" => "Room Only",
        "rooms" => [{
          "roomCategory" => "Double 1 Double Bed",
          "paxes" => [
            { "paxType" => "Adult", "age" => 30, "title" => "Mr", "firstName" => "John", "lastName" => "Doe" },
            { "paxType" => "Adult", "age" => 30, "title" => "Mrs", "firstName" => "Amanda", "lastName" => "Doe" }
          ],
          "totalRoomRate" => 528,
          "ratesPerNight" => [
            { "date" => "2012-10-04", "amount" => 75 },
            { "date" => "2012-10-05", "amount" => 75 },
            { "date" => "2012-10-06", "amount" => 75 },
            { "date" => "2012-10-07", "amount" => 75 },
            { "date" => "2012-10-08", "amount" => 75 },
            { "date" => "2012-10-09", "amount" => 75 },
            { "date" => "2012-10-10", "amount" => 78 }
          ]
        }],
        "cancellationPolicy" => [
          { "cancellationDay" => 7, "feeType" => "Amount", "feeAmount" => 80, "currency" => "EUR", "remarks" => "Guest must notify the Front Desk upon check-in if depature date has changed.Double rooms has one double bed." },
          { "cancellationDay" => 0, "feeType" => "Amount", "feeAmount" => 80, "currency" => "EUR", "remarks" => "" }
        ],
        "agencyReferenceNumber" => "",
        "comments" => ""
      }
    }

    result = HotelsPro::Api::Methods::MakeHotelBooking::Result.new(
      :response_id => 5756635,
      :tracking_d => "XI-HE-70838364",
      :hotel_booking_info => HotelsPro::Api::Elements::BookInfo.new(
        :booking_status => 5,
        :confirmation_number => "TEST;0000000",
        :supplier => nil,
        :hotel_code => "US2HZR",
        :check_in => "2012-10-04",
        :check_out => "2012-10-11",
        :total_price => "528",
        :currency => "EUR",
        :total_sale_price => 0,
        :board_type => "Room Only",
        :rooms => [HotelsPro::Api::Elements::RoomResponse.new(
          :room_category => "Double 1 Double Bed",
          :paxes => [
            HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :age => 30, :title => "Mr", :first_name => "John", :last_name => "Doe"),
            HotelsPro::Api::Elements::Pax.new(:pax_type => "Adult", :age => 30, :title => "Mrs", :first_name => "Amanda", :last_name => "Doe")
          ],
          :total_room_rate => 528,
          :rates_per_night => [
            HotelsPro::Api::Elements::DailyRate.new(:date => "2012-10-04", :amount => 75),
            HotelsPro::Api::Elements::DailyRate.new(:date => "2012-10-05", :amount => 75),
            HotelsPro::Api::Elements::DailyRate.new(:date => "2012-10-06", :amount => 75),
            HotelsPro::Api::Elements::DailyRate.new(:date => "2012-10-07", :amount => 75),
            HotelsPro::Api::Elements::DailyRate.new(:date => "2012-10-08", :amount => 75),
            HotelsPro::Api::Elements::DailyRate.new(:date => "2012-10-09", :amount => 75),
            HotelsPro::Api::Elements::DailyRate.new(:date => "2012-10-10", :amount => 78)
          ]
        )],
        :cancellation_policy => [
          HotelsPro::Api::Elements::Policy.new(:cancellation_day => 7, :fee_type => "Amount", :fee_amount => 80, :currency => "EUR", :remarks => "Guest must notify the Front Desk upon check-in if depature date has changed.Double rooms has one double bed."),
          HotelsPro::Api::Elements::Policy.new(:cancellation_day => 0, :fee_type => "Amount", :fee_amount => 80, :currency => "EUR", :remarks => "")
        ],
        :agency_reference_number => "",
        :comments => ""
      )
    )
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

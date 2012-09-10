require 'spec_helper'

describe HotelsPro::Api::Methods::GetHotelBookingStatus do
  include RequestHelper

  it "should build correct api params hash" do
    method = HotelsPro::Api::Methods::GetHotelBookingStatus.new(
      :tracking_id => "XI-HE-70838364",
    )

    method.to_api_params.should == {
      "trackingId" => "XI-HE-70838364",
    }
  end

  it "should return result when performed" do
    HotelsPro::Stubs.get_hotel_booking_status.response(fixture('get_hotel_booking_status'))

    method = HotelsPro::Api::Methods::GetHotelBookingStatus.new(
      :tracking_id => "XI-HE-70838364",
    )

    result = method.perform

    result.should be_instance_of HotelsPro::Api::Methods::GetHotelBookingStatus::Result
    result.response_id.should == 5761428
    result.tracking_id.should == "XI-HE-70838364"
    result.hotel_booking_info.should be_instance_of HotelsPro::Api::Elements::BookInfo
    result.hotel_booking_info.hotel_code.should == "US2HZR"
  end
end

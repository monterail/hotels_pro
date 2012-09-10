require 'spec_helper'

describe HotelsPro::Api::Methods::CancelHotelBooking do
  include RequestHelper

  it "should build correct api params hash" do
    method = HotelsPro::Api::Methods::CancelHotelBooking.new(
      :tracking_id => "XI-HE-70838364"
    )

    method.to_api_params.should == {
      "trackingId" => "XI-HE-70838364"
    }
  end

  it "should return result when performed" do
    HotelsPro::Stubs.cancel_hotel_booking.response(fixture('cancel_hotel_booking'))

    method = HotelsPro::Api::Methods::CancelHotelBooking.new(
      :tracking_id => "XI-HE-70838364"
    )

    result = method.perform

    result.should be_instance_of HotelsPro::Api::Methods::CancelHotelBooking::Result
    result.response_id.should == 5761559
    result.tracking_id.should == "XI-HE-70838364"
    result.agency_reference_number.should be_empty
    result.booking_status.should == "Cancelled"
    result.note.should == "Booking has been cancelled successfully."
  end
end

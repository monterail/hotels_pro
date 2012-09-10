require 'spec_helper'

describe HotelsPro::Api::Methods::GetHotelCancellationPolicy do
  include RequestHelper

  it "should build correct api params hash" do
    method = HotelsPro::Api::Methods::GetHotelCancellationPolicy.new(
      :tracking_id => "XI-HE-70838364",
    )

    method.to_api_params.should == {
      "trackingId" => "XI-HE-70838364",
    }
  end

  it "should return result when performed" do
    HotelsPro::Stubs.get_hotel_cancellation_policy.response(fixture('get_hotel_cancellation_policy'))

    method = HotelsPro::Api::Methods::GetHotelCancellationPolicy.new(
      :tracking_id => "XI-HE-70838364",
    )

    result = method.perform

    result.should be_instance_of HotelsPro::Api::Methods::GetHotelCancellationPolicy::Result
    result.response_id.should == 5761637
    result.tracking_id.should == "XI-HE-70838364"
    result.agency_reference_number.should be_empty
    result.cancellation_policy.size.should == 2
  end
end

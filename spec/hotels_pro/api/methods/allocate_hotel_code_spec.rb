require 'spec_helper'

describe HotelsPro::Api::Methods::AllocateHotelCode do
  include RequestHelper

  it "should build correct api params hash" do
    method = HotelsPro::Api::Methods::AllocateHotelCode.new(
      :search_id => "VO-40164625",
      :hotel_code => "US6X5G"
    )

    method.to_api_params.should == {
      "searchId" => "VO-40164625",
      "hotelCode" => "US6X5G"
    }
  end

  it "should return result when performed" do
    HotelsPro::Stubs.allocate_hotel_code.response(fixture("allocate_hotel_code"))

    method = HotelsPro::Api::Methods::AllocateHotelCode.new(
      :search_id => "VO-40164625",
      :hotel_code => "US6X5G"
    )

    result = method.perform

    result.should be_instance_of HotelsPro::Api::Methods::AllocateHotelCode::Result
    result.response_id.should == 5752179
    result.total_found.should == 2
    result.search_id.should == "VO-40164625"
    result.hotel_code.should == "US6X5G"
  end
end

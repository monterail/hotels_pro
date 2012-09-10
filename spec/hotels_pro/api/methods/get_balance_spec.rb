require 'spec_helper'

describe HotelsPro::Api::Methods::GetBalance do
  include RequestHelper

  it "should build correct api params hash" do
    method = HotelsPro::Api::Methods::GetBalance.new()

    method.to_api_params.should == {}
  end

  it "should return result when performed" do
    HotelsPro::Stubs.get_balance.response(fixture('get_balance'))

    method = HotelsPro::Api::Methods::GetBalance.new()

    result = method.perform

    result.should be_instance_of HotelsPro::Api::Methods::GetBalance::Result
    result.response_id.should == 5762226
    result.currency.should == "0.00"
    result.total_deposit.should == 0
    result.total_booking_amount.should == 0
    result.current_balance.should == 0
  end
end

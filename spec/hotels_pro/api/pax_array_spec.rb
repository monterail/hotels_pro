require 'spec_helper'

describe HotelsPro::Api::PaxArray do
  it "should return array of Pax elemements as api params" do
    pax_arr = HotelsPro::Api::PaxArray.new
    pax1 = HotelsPro::Api::Pax.new
    pax2 = HotelsPro::Api::Pax.new

    pax_arr.elements << pax1
    pax_arr.elements << pax2

    pax_arr.to_api_params.should == [pax1.to_api_params, pax2.to_api_params]
  end
end
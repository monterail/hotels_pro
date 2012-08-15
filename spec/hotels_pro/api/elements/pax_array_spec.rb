require 'spec_helper'

describe HotelsPro::Api::Elements::PaxArray do
  it "should return array of Pax elemements as api params" do
    pax_arr = HotelsPro::Api::Elements::PaxArray.new
    pax1 = HotelsPro::Api::Elements::Pax.new
    pax2 = HotelsPro::Api::Elements::Pax.new

    pax_arr.paxes << pax1
    pax_arr.paxes << pax2

    pax_arr.to_api_params.should == [pax1.to_api_params, pax2.to_api_params]
  end
end
require 'spec_helper'

describe HotelsPro::Stubs do
  before do
    HotelsPro::Stubs.clear
  end

  it "should add a stub" do
    matcher = lambda { |request| true }
    HotelsPro::Stubs.get_available_hotel(matcher).response("response")

    HotelsPro::Stubs.stubs.size.should == 1
  end

  context "with stub added" do
    before do
      matcher = lambda { |request| request.foo == "bar" }
      HotelsPro::Stubs.get_available_hotel(matcher).response("response")
      HotelsPro::Stubs.stubs.size.should == 1
    end

    it "should clear stubs" do
      HotelsPro::Stubs.clear
      HotelsPro::Stubs.stubs.size.should == 0
    end

    it "should return response when request matches a stub" do
      request = stub(:api_method => 'getAvailableHotel', :foo => "bar")
      HotelsPro::Stubs.match(request).should == "response"
    end

    it "should return nil when request does not match a stub" do
      request = stub(:api_method => 'getAvailableHotel', :foo => "baz")
      HotelsPro::Stubs.match(request).should be_nil
    end
  end
end

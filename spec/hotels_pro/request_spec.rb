require 'spec_helper'

describe HotelsPro::Request do
  include RequestHelper

  before(:each) do
    @request = HotelsPro::Request.new("getAvailableHotel", :param1 => "value1", :param2 => "value2")
  end

  it "should be defined with params hash" do
    @request.params.should == { :param1 => "value1", :param2 => "value2" }
  end

  it "should build query from params, api method and api key" do
    query = @request.query

    query.should =~ /param1=value1/
    query.should =~ /param2=value2/
    query.should =~ /method=getAvailableHotel/
    query.should =~ /apiKey=123/
  end

  it "should build uri from api url and query" do
    @request.uri.should == "#{HotelsPro.configuration.api_url}#{@request.query}"
  end

  it "should return response" do
    stub_url(/getAvailableHotel/, stub_response("get_available_hotel"))

    response = @request.perform
    response.should be_an_instance_of HotelsPro::Response
  end
end
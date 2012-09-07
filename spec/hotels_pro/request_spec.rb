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
    HotelsPro::Stubs.get_available_hotel.response(fixture("get_available_hotel"))

    response = @request.perform
    response.should be_an_instance_of HotelsPro::Response
  end

  context "when only_stubs is true" do
    before do
      @only_stubs = HotelsPro.configuration.only_stubs
      HotelsPro.configure do |config|
        config.only_stubs = true
      end
    end

    after do
      HotelsPro.configure do |config|
        config.only_stubs = @only_stubs
      end
    end

    it "should raise exception when performing unstubbed request" do
      lambda{ @request.perform }.should raise_exception(HotelsPro::UnstubbedRequest)
    end
  end

  context "when only_stubs is false" do
    before do
      @only_stubs = HotelsPro.configuration.only_stubs
      HotelsPro.configure do |config|
        config.only_stubs = false
      end
    end

    after do
      HotelsPro.configure do |config|
        config.only_stubs = @only_stubs
      end
    end

    it "should not raise exception when performing unstubbed request" do
      # Stub it with Typhoeus
      Typhoeus::Hydra.hydra.stub(:get, @request.uri).and_return(Typhoeus::Response.new(:status => 200, :body => "''", :headers => '', :time => 0.1))
      lambda{ @request.perform }.should_not raise_exception
    end
  end
end

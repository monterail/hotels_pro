require 'spec_helper'

describe HotelsPro::Response do
  it "should detect response errors" do
    response = HotelsPro::Response.new('[0, "error message"]')
    response.error?.should be_true
    response.error.should be_instance_of(HotelsPro::ErrorResponse)
    response.error.message.should == "error message"
  end

  it "should detect JSON parsing errors" do
    response = HotelsPro::Response.new('non-json')
    response.error?.should be_true
    response.error.should be_instance_of(HotelsPro::RemoteError)
    response.error.message.should == "Remote API down."
  end

  it "should parse and underscore json response" do
    response = HotelsPro::Response.new('{"paramOne": "value1"}')
    response.error?.should be_false
    response.error.should be_nil
    response.data.should == { "param_one" => "value1" }
  end
end

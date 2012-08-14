require 'spec_helper'

describe HotelsPro::Response do
  it "should detect errors" do
    response = HotelsPro::Response.new('[0, "error message"]')
    response.status.should == :error
    response.error_message.should == "error message"
  end

  it "should parse and underscore json response" do
    response = HotelsPro::Response.new('{"paramOne": "value1"}')
    response.status.should == :success
    response.data.should == { "param_one" => "value1" }
  end
end
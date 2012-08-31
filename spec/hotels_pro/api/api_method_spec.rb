require 'spec_helper'

describe HotelsPro::Api::ApiMethod do
  let(:api_method) { HotelsPro::Api::ApiMethod.new }

  it "should raise exception on error response" do
    response = stub(:error? => true, :error_message => "Error occured.")
    request  = stub(:perform => response)

    api_method.stub(:request => request)

    lambda { api_method.perform }.should raise_error(HotelsPro::ErrorResponse, "Error occured.")
  end
end
require 'spec_helper'

describe HotelsPro::Stubs::Stub do
  it "should set response and return self (be chainable)" do
    matcher = lambda { |request| true }
    the_stub = HotelsPro::Stubs::Stub.new("foo", matcher)
    the_stub.response("bar").should == the_stub
    the_stub.response.should == "bar"
  end

  it "should not match request with different api method" do
    matcher = lambda { |request| true }
    the_stub = HotelsPro::Stubs::Stub.new("foo", matcher).response("response")
    request = stub(:api_method => "bar")

    the_stub.matches?(request).should be_false
  end

  it "should not match request if matcher evaluates to false" do
    matcher = lambda { |request| false }
    the_stub = HotelsPro::Stubs::Stub.new("foo", matcher).response("response")
    request = stub(:api_method => "foo")

    the_stub.matches?(request).should be_false
  end

  it "should match request when api method is correct and matcher evaluates to true" do
    matcher = lambda { |request| true }
    the_stub = HotelsPro::Stubs::Stub.new("foo", matcher).response("response")
    request = stub(:api_method => "foo")

    the_stub.matches?(request).should be_true
  end

  it "should match request when api method is correct and matcher is not set" do
    the_stub = HotelsPro::Stubs::Stub.new("foo").response("response")
    request = stub(:api_method => "foo")

    the_stub.matches?(request).should be_true
  end
end

require 'spec_helper'

describe HotelsPro::Stubs::Stub do
  it "should not match request with different api method" do
    matcher = lambda { |request| true }
    the_stub = HotelsPro::Stubs::Stub.new("foo", matcher, "response")
    request = stub(:api_method => "bar")

    the_stub.matches?(request).should be_false
  end

  it "should not match request if matcher evaluates to false" do
    matcher = lambda { |request| false }
    the_stub = HotelsPro::Stubs::Stub.new("foo", matcher, "response")
    request = stub(:api_method => "foo")

    the_stub.matches?(request).should be_false
  end

  it "should match request when api method is correct and matcher evaluates to true" do
    matcher = lambda { |request| true }
    the_stub = HotelsPro::Stubs::Stub.new("foo", matcher, "response")
    request = stub(:api_method => "foo")

    the_stub.matches?(request).should be_true
  end
end

require 'spec_helper'

describe HotelsPro::Query do
  it "should encode hash" do
    params = { "a" => "1", "b" => "2" }

    query = HotelsPro::Query.new(params)
    query.to_s.should == "?a=1&b=2"
  end

  it "should encode hashes of hashes" do
    params = { "a" => { "b" => "2", "c" => "3" } }

    query = HotelsPro::Query.new(params)
    query.to_s.should == "?a[b]=2&a[c]=3"
  end

  it "should encode hashes of arrays" do
    params = { "a" => ["2", "3"] }

    query = HotelsPro::Query.new(params)
    query.to_s.should == "?a[0]=2&a[1]=3"
  end

  it "should encode hashes of arrays of hashes" do
    params = { "a" => [{ "b" => "2" }, { "c" => "3" }] }

    query = HotelsPro::Query.new(params)
    query.to_s.should == "?a[0][b]=2&a[1][c]=3"
  end

  it "should encode hashes of arrays of arrays of hashes" do
    params = { "a" => [[{ "b" => "2" }, { "c" => "3" }], [{ "d" => "4" }, { "e" => "5" }]] }

    query = HotelsPro::Query.new(params)
    query.to_s.should == "?a[0][0][b]=2&a[0][1][c]=3&a[1][0][d]=4&a[1][1][e]=5"
  end

  it "should escape values" do
    params = { "a" => "foo bar" }

    query = HotelsPro::Query.new(params)
    query.to_s.should == "?a=foo%20bar"
  end
end

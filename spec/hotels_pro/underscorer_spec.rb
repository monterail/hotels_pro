require 'spec_helper'

describe HotelsPro::Underscorer do
  before do
    @u = Object.new
    @u.extend HotelsPro::Underscorer
  end

  it "should underscore hash keys" do
    underscored = @u.underscore("paramOne" => "value1", "paramTwo" => "value2")
    underscored.should == { "param_one" => "value1", "param_two" => "value2" }
  end

  it "should underscore nested hash's keys" do
    underscored = @u.underscore("a" => { "paramTwo" => "value2" })
    underscored.should == { "a" => { "param_two" => "value2" } }
  end

  it "should underscore keys of hashes found in arrays" do
    underscored = @u.underscore( [{ "paramOne" => "value1" }, { "paramTwo" => "value2" }])
    underscored.should == [{ "param_one" => "value1" }, { "param_two" => "value2" }]
  end

  it "should underscore keys of hashes found in nested arrays" do
    underscored = @u.underscore( "a" => [{ "paramOne" => "value1" }, { "paramTwo" => "value2" }])
    underscored.should == { "a" => [{ "param_one" => "value1" }, { "param_two" => "value2" }]}
  end

  it "should not fail on non-hashes or non-arrays" do
    underscored = @u.underscore("foo")
    underscored.should == "foo"
  end
end
require 'spec_helper'

describe HotelsPro::Api::ApiParams do
  before do
    @object = Object.new
    @object.extend HotelsPro::Api::ApiParams
    @object.stub(:attributes).and_return({ :param_one => "value1", :param_two => "value2", :param_three => nil, :param_four => [], :param_five => {} })
  end

  describe ".to_api_params" do
    it "should stringify and camelize attributes' names" do
      @object.api_param_name(:param_one).should == "paramOne"
    end

    it "should only include attributes with non-empty values" do
      @object.to_api_params.should == { "paramOne" => "value1", "paramTwo" => "value2" }
    end
  end
end
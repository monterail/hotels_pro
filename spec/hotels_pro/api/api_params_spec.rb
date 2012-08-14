require 'spec_helper'

describe HotelsPro::Api::ApiParams do
  include ApiParamsHelper

  before do
    @object = mock_api_object({ :param_one => "value1", :param_two => "value2", :param_three => nil, :param_four => [], :param_five => {} })
  end

  describe ".to_api_params" do
    it "should stringify and camelize attribute name" do
      @object.api_param_name(:param_one).should == "paramOne"
    end

    it "should only include attributes with non-empty values" do
      @object.to_api_params.should == { "paramOne" => "value1", "paramTwo" => "value2" }
    end

    it "should try to call to_api_params on value" do
      child_object = mock_api_object({ :param_one => "value1" })

      @object.api_param_value(child_object).should == { "paramOne" => "value1" }
    end

    it "should try to call to_api_params on all elements of value if value is Enumerable" do
      child_object1 = mock_api_object({ :param_one => "value1" })
      child_object2 = mock_api_object({ :param_two => "value2" })

      @object.api_param_value([child_object1, child_object2]).should == [{ "paramOne" => "value1" }, { "paramTwo" => "value2" }]
    end

    it "should stringify attribute value if it does not respond to :to_api_params" do
      @object.api_param_value(:value).should == "value"
    end
  end
end
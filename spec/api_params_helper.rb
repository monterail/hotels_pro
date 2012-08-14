module ApiParamsHelper
  def mock_api_object(attributes)
    object = Object.new
    object.extend HotelsPro::Api::ApiParams
    object.stub(:attributes).and_return(attributes)
    object
  end
end
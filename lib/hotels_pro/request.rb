module HotelsPro
  class Request
    attr_accessor :api_method, :params

    def initialize(api_method, params={})
      @api_method = api_method.camelize(:lower)
      @params = params
    end

    def query
      params = @params.dup
      params["method"] = api_method
      params["apiKey"] = HotelsPro.configuration.api_key

      Query.new(params).to_s
    end

    def uri
      "#{HotelsPro.configuration.api_url}#{query}"
    end

    def perform
      HotelsPro.log("Request URL: #{uri}")
      api_response = Typhoeus::Request.get(uri)
      response = Response.new(api_response.body)
      HotelsPro.log("Response: #{response.inspect}")
      response
    end
  end
end
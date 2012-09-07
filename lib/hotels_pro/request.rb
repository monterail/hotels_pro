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

      response = Response.new(stubbed_response || real_response)

      HotelsPro.log("Response: #{response.inspect}")
      response
    end

    def stubbed_response
      response = HotelsPro::Stubs.match(self)
      if !response && HotelsPro.configuration.only_stubs
        raise HotelsPro::UnstubbedRequest.new("Unstubbed request to URL: #{uri}")
      end
      response
    end

    def real_response
      Typhoeus::Request.get(uri).body
    end
  end
end

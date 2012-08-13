module HotelsPro
  class Request
    attr_accessor :api_method, :params

    def initialize(api_method, params={})
      @api_method = api_method.camelize(false)
      @params = params
    end

    def query
      params = @params.dup
      params["method"] = api_method
      params["apiKey"] = HotelsPro.configuration.api_key

      query = params.inject([]) do |arr, (k, v)|
        unless v.nil?
          k = k.to_s.camelize(false)
          arr << "#{k}=#{v}"
        end
        arr
      end

      query.join("&")
    end

    def uri
      "#{HotelsPro.configuration.api_url}?#{query}"
    end

    def perform
      response = Typhoeus::Request.get(uri)
      Response.new(response.body)
    end
  end
end
module HotelsPro
  class Request
    attr_accessor :params

    def initialize(params={})
      @params = params
    end

    def query
      params = @params.dup
      params["apiKey"] = HotelsPro.configuration.api_key

      query = params.inject([]) do |arr, (k, v)|
        arr << "#{k}=#{v}"
        arr
      end

      query.join("&")
    end

    def uri
      "#{HotelsPro.configuration.api_url}?#{query}"
    end

    def perform
    end
  end
end
require 'open-uri'

module HotelsPro
  class Query
    def initialize(api_params)
      chunks = api_params.inject([]) do |arr, (k, v)|
        arr << encode(k, v)
        arr
      end
      @query = "?" << chunks.join("&")
    end

    def to_s
      @query
    end

    def encode(key, value)
      case value
      when Hash
        chunks = value.map do |k, v|
          encode("#{key}[#{k}]", v)
        end
        chunks.join("&")
      when Array
        chunks = value.each_with_index.map do |v, i|
          encode("#{key}[#{i}]", v)
        end
        chunks.join("&")
      else
        "#{key}=#{URI::encode(value)}"
      end
    end
  end
end

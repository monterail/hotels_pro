require "hotels_pro/underscorer"

module HotelsPro
  class Response
    include Underscorer

    attr_reader :error_message, :data, :error

    def initialize(json)
      @data = underscore(body(json))
      detect_error(data)
    end

    # HotelsPro API returns status 200 OK for errors and includes error message in body as:
    # [0, "error message"]
    def detect_error(data)
      if data.is_a?(Array) && data.size == 2 && data[0] == 0
        @error = ErrorResponse.new(data[1])
      end
    end

    def error?
      !error.nil?
    end

    def body(json)
      JSON.parse(json)
    rescue JSON::ParserError
      @error = RemoteError.new("Remote API down.")
      nil
    end
  end
end

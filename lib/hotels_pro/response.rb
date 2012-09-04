require "hotels_pro/underscorer"

module HotelsPro
  class Response
    include Underscorer

    attr_reader :status, :error_message, :data

    def initialize(json)
      @data = underscore(body(json))
      detect_error

      @status = error_message.nil? ? :success : :error
    end

    # HotelsPro API returns status 200 OK for errors and includes error message in body as:
    # [0, "error message"]
    def detect_error
      if data.size == 2 and data[0] == 0
        @error_message = data[1]
      end
    end

    def error?
      @status == :error
    end

    def success?
      @status == :success
    end

    def body(json)
      JSON.parse(json)
    rescue JSON::ParserError
      raise RemoteError.new("Remote API down.")
    end
  end
end
module HotelsPro
  class Response
    attr_reader :status, :error_message, :data

    def initialize(body)
      @data = JSON.parse(body)
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
  end
end
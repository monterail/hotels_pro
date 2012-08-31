module HotelsPro
  module Api
    class ApiMethod
      include ApiParams

      def perform
        api_method = self.class.name.to_s.demodulize
        request = Request.new(api_method, to_api_params)
        response = request.perform
        if response.error?
          raise ErrorResponse.new(response.error_message)
        else
          "#{self.class.name}::Result".constantize.new(response.data)
        end
      end
    end
  end
end
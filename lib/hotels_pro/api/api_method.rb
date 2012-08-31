module HotelsPro
  module Api
    class ApiMethod
      include ApiParams
      include Virtus

      class Result
        include Virtus
      end

      def perform
        response = request.perform

        if response.error?
          raise ErrorResponse.new(response.error_message)
        else
          "#{self.class.name}::Result".constantize.new(response.data)
        end
      end

      private

      def request
        api_method = self.class.name.to_s.demodulize
        Request.new(api_method, to_api_params)
      end
    end
  end
end
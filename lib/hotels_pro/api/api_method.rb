module HotelsPro
  module Api
    class ApiMethod
      def perform
        api_method = self.class.name.to_s.demodulize
        request = Request.new(api_method, attributes)
        request.perform
      end
    end
  end
end
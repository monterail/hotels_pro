module HotelsPro
  module Stubs
    class Stub
      attr_reader :response

      def initialize(api_method, matcher, response)
        @api_method = api_method
        @matcher = matcher
        @response = response
      end

      def matches?(request)
        request.api_method == @api_method && @matcher.call(request)
      end
    end
  end
end

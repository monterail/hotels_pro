module HotelsPro
  module Stubs
    class Stub
      def initialize(api_method, matcher=nil)
        @api_method = api_method
        @matcher = matcher
      end

      def response(resp=nil)
        if resp
          @response = resp
          self
        else
          @response
        end
      end

      def matches?(request)
        request.api_method == @api_method && (@matcher.nil? || @matcher.call(request))
      end
    end
  end
end

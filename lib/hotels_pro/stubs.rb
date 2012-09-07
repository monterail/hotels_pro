module HotelsPro
  module Stubs
    class << self
      def stubs
        @stubs ||= []
      end

      def clear
        @stubs = []
      end

      def get_available_hotel(matcher, response)
        stub = Stub.new('getAvailableHotel', matcher, response)
        stubs << stub
      end

      def match(request)
        stub = stubs.find { |s| s.matches?(request) }
        stub.response if stub
      end
    end
  end
end

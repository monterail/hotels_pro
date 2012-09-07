module HotelsPro
  module Stubs
    class << self
      def stubs
        @stubs ||= []
      end

      def clear
        @stubs = []
      end

      def get_available_hotel(matcher=nil)
        stub = Stub.new('getAvailableHotel', matcher)
        stubs << stub
        stub
      end

      def match(request)
        stub = stubs.find { |s| s.matches?(request) }
        stub.response if stub
      end
    end
  end
end

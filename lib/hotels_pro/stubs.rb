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

      def allocate_hotel_code(matcher=nil)
        stub = Stub.new('allocateHotelCode', matcher)
        stubs << stub
        stub
      end

      def make_hotel_booking(matcher=nil)
        stub = Stub.new('makeHotelBooking', matcher)
        stubs << stub
        stub
      end

      def get_hotel_booking_status(matcher=nil)
        stub = Stub.new('getHotelBookingStatus', matcher)
        stubs << stub
        stub
      end

      def cancel_hotel_booking(matcher=nil)
        stub = Stub.new('cancelHotelBooking', matcher)
        stubs << stub
        stub
      end

      def get_hotel_cancellation_policy(matcher=nil)
        stub = Stub.new('getHotelCancellationPolicy', matcher)
        stubs << stub
        stub
      end

      def amend_hotel_booking(matcher=nil)
        stub = Stub.new('amendHotelBooking', matcher)
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

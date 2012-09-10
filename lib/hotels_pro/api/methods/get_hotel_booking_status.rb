require 'hotels_pro/api/elements/book_info'

module HotelsPro
  module Api
    module Methods
      class GetHotelBookingStatus < ApiMethod
        include ApiParams
        include Virtus

        attribute :tracking_id, String

        class Result < ApiMethod::Result
          attribute :response_id, Integer
          attribute :tracking_id, String
          attribute :agency_reference_number, String
          attribute :hotel_booking_info, HotelsPro::Api::Elements::BookInfo
        end
      end
    end
  end
end

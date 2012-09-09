require 'hotels_pro/api/elements/book_info'
require 'hotels_pro/api/elements/lead_traveller'
require 'hotels_pro/api/elements/pax_array'

module HotelsPro
  module Api
    module Methods
      class MakeHotelBooking < ApiMethod
        attribute :process_id, String
        attribute :agency_reference_number, String
        attribute :lead_traveller_info, HotelsPro::Api::Elements::LeadTraveller
        attribute :other_traveller_info, Array[Api::Elements::Pax], :default => []
        attribute :preferences, String
        attribute :note, String

        class Result < ApiMethod::Result
          attribute :response_id, Integer
          attribute :tracking_id, Integer
          attribute :hotel_booking_info, HotelsPro::Api::Elements::BookInfo
        end
      end
    end
  end
end

require 'hotels_pro/api/elements/book_info'
require 'hotels_pro/api/elements/lead_traveller'
require 'hotels_pro/api/elements/pax_array'

module HotelsPro
  module Api
    module Methods
      class AmendHotelBooking < ApiMethod
        attribute :tracking_id, String
        attribute :check_in, Date
        attribute :check_out, Date
        attribute :lead_traveller_info, Api::Elements::LeadTraveller
        attribute :rooms, Array[Api::Elements::PaxArray], :default => []
        attribute :preferences, String
        attribute :note, String

        class Result < ApiMethod::Result
          attribute :response_id, Integer
          attribute :tracking_id, Integer
          attribute :agency_reference_number, String
          attribute :amend_status, String
          attribute :note, String
        end
      end
    end
  end
end

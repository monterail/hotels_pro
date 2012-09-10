module HotelsPro
  module Api
    module Methods
      class CancelHotelBooking < ApiMethod
        include ApiParams
        include Virtus

        attribute :tracking_id, String

        class Result < ApiMethod::Result
          attribute :response_id, Integer
          attribute :tracking_id, String
          attribute :agency_reference_number, String
          attribute :booking_status, String
          attribute :note, String
        end
      end
    end
  end
end

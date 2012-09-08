require 'hotels_pro/api/elements/hotel'

module HotelsPro
  module Api
    module Methods
      class AllocateHotelCode < ApiMethod

        attribute :search_id, String
        attribute :hotel_code, String

        class Result < ApiMethod::Result
          attribute :response_id, Integer
          attribute :search_id, String
          attribute :hotel_code, String
          attribute :available_hotels, Array[Api::Elements::Hotel]
          attribute :total_found, Integer
        end
      end
    end
  end
end

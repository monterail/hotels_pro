require 'hotels_pro/api/elements/pax'

module HotelsPro
  module Api
    module Elements
      class RoomResponse
        include Virtus

        attribute :room_category, String
        attribute :paxes, Array[Pax]
        attribute :total_room_rate, Float
        attribute :rates_per_night, Array[DailyRate]
      end
    end
  end
end
module HotelsPro
  module Api
    class Hotel
      include Virtus

      attribute :process_id, String
      attribute :hotel_code, String
      attribute :availability_status, String
      attribute :special_deal, Integer
      attribute :total_price, Float
      attribute :total_tax, Float, :default => 0
      attribute :total_sale_price, Float, :default => 0
      attribute :currency, String
      attribute :board_type, String
      attribute :rooms, Array[RoomResponse], :default => []
    end
  end
end
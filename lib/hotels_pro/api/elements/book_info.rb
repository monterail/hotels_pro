require 'hotels_pro/api/elements/pax_array'
require 'hotels_pro/api/elements/policy'

module HotelsPro
  module Api
    module Elements
      class BookInfo
        include Virtus

        attribute :booking_status, Integer
        attribute :confirmation_number, String
        attribute :supplier, String
        attribute :hotel_code, String
        attribute :check_in, Date
        attribute :check_out, Date
        attribute :total_price, Float
        attribute :total_sale_price, Float
        attribute :currency, String
        attribute :board_type, String
        attribute :rooms, Array[HotelsPro::Api::Elements::PaxArray], :default => []
        attribute :cancellation_policy, Array[HotelsPro::Api::Elements::Policy], :default => []
        attribute :agency_reference_number, String
        attribute :comments, String
      end
    end
  end
end

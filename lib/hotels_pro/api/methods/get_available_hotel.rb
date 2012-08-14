require 'hotels_pro/api/elements/pax_array'

module HotelsPro
  module Api
    module Methods
      class GetAvailableHotel < ApiMethod
        include ApiParams
        include Virtus

        attribute :destination_id, String
        attribute :check_in, Date
        attribute :check_out, Date
        attribute :currency, String, :default => "EUR"
        attribute :client_nationality, String
        attribute :on_request, Boolean, :default => true
        attribute :rooms, Array[Api::Elements::PaxArray], :default => []
        attribute :filters, Array, :default => []
      end
    end
  end
end
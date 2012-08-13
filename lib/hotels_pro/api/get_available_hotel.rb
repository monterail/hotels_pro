module HotelsPro
  module Api
    class GetAvailableHotel
      include Api

      attribute :destination_id, String
      attribute :check_in, Date
      attribute :check_out, Date
      attribute :currency, String, :default => "EUR"
      attribute :client_nationality, String
      attribute :on_request, Boolean, :default => true
      attribute :rooms, Array
      attribute :filters, Array
    end
  end
end